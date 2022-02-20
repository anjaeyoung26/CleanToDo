//
//  ToDo.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/09.
//

import Foundation

struct ToDo {
  var id: Int16
  var title: String
  var content: String
  var startDate: Date
  var dueDate: Date
}


// MARK: - Fixture

extension ToDo {
  static func fixture(
    id: Int16,
    title: String = "",
    content: String = "",
    startDate: Date = Date(),
    dueDate: Date = Date()
  ) -> ToDo {
    return .init(
      id: id,
      title: title,
      content: content,
      startDate: startDate,
      dueDate: dueDate
    )
  }
}


// MARK: - Equatable

extension ToDo: Equatable {
  static func == (lhs: ToDo, rhs: ToDo) -> Bool {
    return lhs.id == rhs.id
  }
}
