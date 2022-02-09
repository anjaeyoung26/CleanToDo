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

extension ToDo {
  static func fixture(
    id: Int16 = 0,
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
