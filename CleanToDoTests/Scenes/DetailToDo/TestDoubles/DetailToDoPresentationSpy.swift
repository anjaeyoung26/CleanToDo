//
//  DetailToDoPresentationSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/22.
//

@testable import CleanToDo

class DetailToDoPresentationSpy: DetailToDoPresentationLogic {
  public var didPresentToDoCalled: Bool = false
  public var didDeleteToDoCalled: Bool = false
  public var didUpdateToDoCalled: Bool = false
  
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
