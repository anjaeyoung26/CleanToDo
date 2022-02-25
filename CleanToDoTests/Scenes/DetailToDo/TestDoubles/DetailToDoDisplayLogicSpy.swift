//
//  DetailToDoDisplayLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/23.
//

@testable import CleanToDo

class DetailToDoDisplayLogicSpy: DetailToDoDisplayLogic {
  var didDisplayToDoCalled: Bool = false
  var didDeleteToDoCalled: Bool = false
  var didUpdateToDoCalled: Bool = false
  
  var error: ToDosCoreDataManagerError!
  var todo: ToDo!
  
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
