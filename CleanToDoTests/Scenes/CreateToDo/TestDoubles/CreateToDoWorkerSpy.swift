//
//  CreateToDoWorkerSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo

class CreateToDoWorkerSpy: CreateToDoWorkerLogic {
  var didCreateToDoCalled: Bool = false
  
  func createToDo(_ todo: ToDo, completion: @escaping CreateCompletion) {
    didCreateToDoCalled = true
    completion(nil, todo)
  }
}
