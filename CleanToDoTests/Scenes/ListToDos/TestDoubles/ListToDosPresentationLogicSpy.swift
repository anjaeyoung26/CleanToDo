//
//  ListToDosPresentationLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

@testable import CleanToDo

class ListToDosPresentationLogicSpy: ListToDosPresentationLogic {
  public var didPresentToDosCalled: Bool = false
  
  func presentToDos(response: ListToDos.GetToDos.Response) {
    didPresentToDosCalled = true
  }
}
