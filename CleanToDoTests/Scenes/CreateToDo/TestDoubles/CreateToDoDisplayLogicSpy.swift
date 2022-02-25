//
//  CreateToDoDisplayLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo

class CreateToDoDisplayLogicSpy: CreateToDoDisplayLogic {
  public var didCreateTodoCalled: Bool = false
  public var error: ToDosCoreDataManagerError!
  
  func createToDo(viewModel: CreateToDo.CreateToDo.ViewModel) {
    didCreateTodoCalled = true
    error = viewModel.error
  }
}
