//
//  DetailToDoBusinessLogicSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/24.
//

@testable import CleanToDo

class DetailToDoBusinessLogicSpy: DetailToDoBusinessLogic {
  var didGetToDoCalled: Bool = false
  var didDeleteToDoCalled: Bool = false
  var didUpdateToDoCalled: Bool = false
  
  func getToDo(request: DetailToDo.GetToDo.Request) {
    didGetToDoCalled = true
  }
  
  func deleteToDo(request: DetailToDo.DeleteToDo.Request) {
    didDeleteToDoCalled = true
  }
  
  func updateToDo(request: DetailToDo.UpdateToDo.Request) {
    didUpdateToDoCalled = true
  }
}
