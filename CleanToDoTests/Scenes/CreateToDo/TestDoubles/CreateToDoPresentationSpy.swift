//
//  CreateToDoPresentationSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo

class CreateToDoPresentationSpy: CreateToDoPresentationLogic {
  var didCreateToDoCalled: Bool = false
  
  func createToDo(response: CreateToDo.CreateToDo.Response) {
    didCreateToDoCalled = true
  }
}
