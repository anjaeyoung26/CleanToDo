//
//  ListToDosWorkerSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

import Foundation
@testable import CleanToDo

class ListToDosWorkerSpy: ListToDosWorkerLogic {
  public var didRequestToDosCalled: Bool = false
  
  func requestToDos(date: Date, completion: @escaping FetchToDosCompletion) {
    didRequestToDosCalled = true
    
    completion([
      ToDo.fixture(id: 1, title: "Title1", content: "Content1"),
      ToDo.fixture(id: 2, title: "Title2", content: "Content2")
    ])
  }
}
