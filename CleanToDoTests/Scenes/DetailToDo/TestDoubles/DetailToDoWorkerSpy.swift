//
//  DetailToDoWorkerSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/22.
//

@testable import CleanToDo

class DetailToDoWorkerSpy: DetailToDoWorkerLogic {
  public var didDeleteToDoCalled: Bool = false
  public var didUpdateToDoCalled: Bool = false
  
  func deleteToDo(id: Int16, completion: @escaping ErrorCompletion) {
    didDeleteToDoCalled = true
    completion(nil)
  }
  
  func updateToDo(todo: ToDo, completion: @escaping UpdateCompletion) {
    didUpdateToDoCalled = true
    completion(nil, todo)
  }
}
