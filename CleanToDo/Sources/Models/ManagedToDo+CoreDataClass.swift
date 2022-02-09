//
//  ManagedToDo+CoreDataClass.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/09.
//
//

import CoreData
import Foundation


public class ManagedToDo: NSManagedObject {
  func toToDo() -> ToDo {
    return ToDo(
      id: id,
      title: title!,
      content: content!,
      startDate: startDate!,
      dueDate: dueDate!
    )
  }
  
  func fromToDo(_ todo: ToDo) {
    id = todo.id
    title = todo.title
    content = todo.content
    startDate = todo.startDate
    dueDate = todo.dueDate
  }
}
