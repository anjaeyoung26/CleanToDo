//
//  DetailToDoInteractorTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/22.
//

import XCTest
@testable import CleanToDo

class DetailToDoInteractorTests: XCTestCase {
  private var sut: DetailToDoInteractor!
  
  override func setUp() {
    super.setUp()
    
    sut = DetailToDoInteractor()
    sut.todo = ToDo.fixture(id: 1)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testGetToDoShouldCallPresenter() {
    // Given
    let presenter = DetailToDoPresentationSpy()
    sut.presenter = presenter
    
    // When
    let request = DetailToDo.GetToDo.Request()
    sut.getToDo(request: request)
    
    // Then
    XCTAssertTrue(presenter.didPresentToDoCalled)
  }
  
  func testDeleteToDoShouldCallWorkerAndPresenter() {
    // Given
    let presenter = DetailToDoPresentationSpy()
    let worker = DetailToDoWorkerSpy()
    
    sut.presenter = presenter
    sut.worker = worker
    
    // When
    let request = DetailToDo.DeleteToDo.Request()
    sut.deleteToDo(request: request)
    
    // Then
    XCTAssertTrue(presenter.didDeleteToDoCalled)
    XCTAssertTrue(worker.didDeleteToDoCalled)
  }
  
  func testUpdateToDoShouldCallWorkerAndPresenter() {
    // Given
    let presenter = DetailToDoPresentationSpy()
    let worker = DetailToDoWorkerSpy()
    
    sut.presenter = presenter
    sut.worker = worker
    
    // When
    let updatedToDo = ToDo.fixture(id: 1, title: "Update")
    let request = DetailToDo.UpdateToDo.Request(todo: updatedToDo)
    sut.updateToDo(request: request)
    
    // Then
    XCTAssertTrue(presenter.didUpdateToDoCalled)
    XCTAssertTrue(worker.didUpdateToDoCalled)
    XCTAssertEqual(sut.todo.title, "Update")
  }
}
