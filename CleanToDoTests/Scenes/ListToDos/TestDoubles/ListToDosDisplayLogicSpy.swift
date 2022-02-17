//
//  ListToDosDisplayLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

@testable import CleanToDo

class ListToDosDisplayLogicSpy: ListToDosDisplayLogic {
  public var didDisplayToDosCalled: Bool = false
  public var viewModel: ListToDos.GetToDos.ViewModel!
  
  func displayToDos(viewModel: ListToDos.GetToDos.ViewModel) {
    didDisplayToDosCalled = true
    self.viewModel = viewModel
  }
}
