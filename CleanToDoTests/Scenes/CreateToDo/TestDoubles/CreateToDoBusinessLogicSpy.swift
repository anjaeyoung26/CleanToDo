//
//  CreateToDoBusinessLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo

class CreateToDoBusinessLogicSpy: CreateToDoBusinessLogic {
  var didCreateToDoCalled: Bool = false
  
  func createToDo(request: CreateToDo.CreateToDo.Request) {
    didCreateToDoCalled = true
  }
}
