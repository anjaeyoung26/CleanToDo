//
//  ToDosCoreDataManager.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/09.
//

import Foundation

protocol ToDosCoreDataManagerProtocol {
  func fetchToDo(id: Int) -> ToDo?
  func fetchToDos(date: Date) -> [ToDo]?
  func deleteToDo(id: Int) throws
  @discardableResult func createToDo(_ todo: ToDo) throws -> ToDo
  @discardableResult func updateToDo(_ todo: ToDo) throws -> ToDo
}


// MARK: - ToDosCoreDataManagerError

enum ToDosCoreDataManagerError: Error {
  case alreadyExist
  case notExist
}


// MARK: - ToDosCoreDataManager

class ToDosCoreDataManager {
  
}
