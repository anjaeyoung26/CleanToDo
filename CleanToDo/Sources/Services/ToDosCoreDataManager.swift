//
//  ToDosCoreDataManager.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/09.
//

import CoreData
import Foundation

typealias FetchToDoCompletion = (ToDo?) -> Void
typealias FetchToDosCompletion = ([ToDo]?) -> Void
typealias ErrorCompletion = (ToDosCoreDataManagerError?) -> Void
typealias CreateCompletion = (ToDosCoreDataManagerError?, ToDo?) -> Void
typealias UpdateCompletion = (ToDosCoreDataManagerError?, ToDo?) -> Void


// MARK: ToDosCoreDataManagerProtocol

protocol ToDosCoreDataManagerProtocol {
  func fetchToDo(id: Int16, completion: @escaping FetchToDoCompletion)
  func fetchToDos(date: Date, completion: @escaping FetchToDosCompletion)
  func deleteToDo(id: Int16, completion: @escaping ErrorCompletion)
  func deleteAllToDos(completion: @escaping ErrorCompletion)
  func createToDo(_ todo: ToDo, completion: @escaping CreateCompletion)
  func updateToDo(_ todo: ToDo, completion: @escaping UpdateCompletion)
  
  var context: NSManagedObjectContext { get }
}


// MARK: - ToDosCoreDataManagerError

enum ToDosCoreDataManagerError: Error {
  case canNotSave(Error)
  case alreadyExist
  case notExist
}

extension ToDosCoreDataManagerError: Equatable {
  static func ==(lhs: ToDosCoreDataManagerError, rhs: ToDosCoreDataManagerError) -> Bool {
    switch (lhs, rhs) {
    case (.alreadyExist, .alreadyExist): return true
    case (.canNotSave, .canNotSave): return true
    case (.notExist, .notExist): return true
    default: return false
    }
  }
}


// MARK: - ToDosCoreDataManagerStorageTyep

enum ToDosCoreDataManagerType {
  case persistent
  case inMemory
}


// MARK: - ToDosCoreDataManager

class ToDosCoreDataManager: ToDosCoreDataManagerProtocol {
  private var container: NSPersistentContainer
  
  private(set) lazy var context: NSManagedObjectContext = {
    return container.newBackgroundContext()
  }()
  
  init(type: ToDosCoreDataManagerType) {
    let container = NSPersistentContainer(name: "CleanToDo")
    container.loadPersistentStores { description, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    if type == .inMemory {
      let description = NSPersistentStoreDescription()
      description.shouldAddStoreAsynchronously = false
      description.url = URL(fileURLWithPath: "/dev/null")
      container.persistentStoreDescriptions = [description]
    }
    
    self.container = container
  }
  
  func fetchToDo(id: Int16, completion: @escaping FetchToDoCompletion) {
    let request = NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
    request.predicate = NSPredicate(format: "id == %ld", id)
    
    context.perform {
      let managedToDo = try? self.context.fetch(request).first
      let todo = managedToDo?.toToDo()
      completion(todo)
    }
  }
  
  func fetchToDos(date: Date, completion: @escaping FetchToDosCompletion) {
    let startOfDay = Calendar.current.startOfDay(for: date) as NSDate
    let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)! as NSDate
    
    let startPredicate = NSPredicate(format: "startDate >= %@ AND startDate <= %@", startOfDay, endOfDay)
    let duePredicate = NSPredicate(format: "dueDate >= %@ AND dueDate <= %@", startOfDay, endOfDay)
    let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: false)
    
    let request = NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate, duePredicate])
    request.sortDescriptors = [sortDescriptor]
    
    context.perform {
      let managedToDos = try? self.context.fetch(request)
      let todos = managedToDos?.compactMap { $0.toToDo() }
      completion(todos)
    }
  }
  
  func deleteToDo(id: Int16, completion: @escaping ErrorCompletion) {
    let request = NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
    request.predicate = NSPredicate(format: "id == %ld", id)
    
    context.perform {
      if let managedToDo = try? self.context.fetch(request).first {
        self.context.delete(managedToDo)
        
        do {
          try self.context.save()
          completion(nil)
        } catch {
          completion(ToDosCoreDataManagerError.canNotSave(error))
        }
      } else {
        completion(ToDosCoreDataManagerError.notExist)
      }
    }
  }
  
  func deleteAllToDos(completion: @escaping ErrorCompletion) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedToDo")
    let batch = NSBatchDeleteRequest(fetchRequest: request)
    
    context.perform {
      do {
        try self.context.execute(batch)
        completion(nil)
      } catch {
        completion(ToDosCoreDataManagerError.canNotSave(error))
      }
    }
  }
  
  func createToDo(_ todo: ToDo, completion: @escaping CreateCompletion) {
    let request = NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
    request.predicate = NSPredicate(format: "id == %ld", todo.id)
    
    guard let count = try? context.count(for: request), count == .zero else {
      completion(ToDosCoreDataManagerError.alreadyExist, nil)
      return
    }
    
    let entity = NSEntityDescription.entity(forEntityName: "ManagedToDo", in: context)!
    let managedToDo = NSManagedObject(entity: entity, insertInto: context) as! ManagedToDo
    managedToDo.fromToDo(todo)
    
    context.perform {
      do {
        try self.context.save()
        completion(nil, todo)
      } catch {
        completion(ToDosCoreDataManagerError.canNotSave(error), nil)
      }
    }
  }
  
  func updateToDo(_ todo: ToDo, completion: @escaping UpdateCompletion) {
    let request = NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
    request.predicate = NSPredicate(format: "id == %ld", todo.id)
    
    context.perform {
      if let managedToDo = try? self.context.fetch(request).first {
        managedToDo.fromToDo(todo)
        
        do {
          try self.context.save()
          completion(nil, todo)
        } catch {
          completion(ToDosCoreDataManagerError.canNotSave(error), nil)
        }
      } else {
        completion(ToDosCoreDataManagerError.notExist, nil)
      }
    }
  }
}
