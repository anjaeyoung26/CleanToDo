//
//  DetailToDoDisplayLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/23.
//

@testable import CleanToDo

class DetailToDoDisplayLogicSpy: DetailToDoDisplayLogic {
  public var didDisplayToDoCalled: Bool = false
  public var didDeleteToDoCalled: Bool = false
  public var didUpdateToDoCalled: Bool = false
  
  public var error: ToDosCoreDataManagerError!
  public var todo: ToDo!
  
  func displayToDo(viewModel: DetailToDo.GetToDo.ViewModel) {
    didDisplayToDoCalled = true
    todo = viewModel.todo
  }
  
  func deleteToDo(viewModel: DetailToDo.DeleteToDo.ViewModel) {
    didDeleteToDoCalled = true
    error = viewModel.error
    todo = nil
  }
  
  func updateToDo(viewModel: DetailToDo.UpdateToDo.ViewModel) {
    didUpdateToDoCalled = true
    error = viewModel.error
    todo = viewModel.todo
  }
}
