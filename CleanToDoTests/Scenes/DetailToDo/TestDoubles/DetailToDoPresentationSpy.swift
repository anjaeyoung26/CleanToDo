//
//  DetailToDoPresentationSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/22.
//

@testable import CleanToDo

class DetailToDoPresentationSpy: DetailToDoPresentationLogic {
  var didPresentToDoCalled: Bool = false
  var didDeleteToDoCalled: Bool = false
  var didUpdateToDoCalled: Bool = false
  
  func presentToDo(response: DetailToDo.GetToDo.Response) {
    didPresentToDoCalled = true
  }
  
  func deleteToDo(response: DetailToDo.DeleteToDo.Response) {
    didDeleteToDoCalled = true
  }
  
  func updateToDo(response: DetailToDo.UpdateToDo.Response) {
    didUpdateToDoCalled = true
  }
}
