//
//  ListToDosBusinessLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/19.
//

@testable import CleanToDo

class ListToDosBusinessLogicSpy: ListToDosBusinessLogic {
  var didRequestToDosCalled: Bool = false
  
  func requestToDos(request: ListToDos.GetToDos.Request) {
    didRequestToDosCalled = true
  }
}
