//
//  ListToDosDisplayLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

@testable import CleanToDo

class ListToDosDisplayLogicSpy: ListToDosDisplayLogic {
  public var didDisplayToDosCalled: Bool = false
  public var todos: [ToDo]!
  
  func displayToDos(viewModel: ListToDos.GetToDos.ViewModel) {
    didDisplayToDosCalled = true
    todos = viewModel.todos
  }
}
