//
//  ManagedToDo+CoreDataProperties.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/09.
//
//

import CoreData
import Foundation

extension ManagedToDo {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedToDo> {
    return NSFetchRequest<ManagedToDo>(entityName: "ManagedToDo")
  }
  
  @NSManaged public var id: Int16
  @NSManaged public var title: String?
  @NSManaged public var content: String?
  @NSManaged public var startDate: Date?
  @NSManaged public var dueDate: Date?
}
