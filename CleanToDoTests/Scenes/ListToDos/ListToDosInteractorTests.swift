//
//  ListToDosInteractorTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

@testable import CleanToDo
import XCTest

class ListToDosInteractorTests: XCTestCase {
  private var sut: ListToDosInteractor!
  
  override func setUp() {
    super.setUp()
    sut = ListToDosInteractor()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testRequestToDosShouldCallWorkerAndPresenter() {
    // Given
    let presenter = ListToDosPresentationLogicSpy()
    let worker = ListToDosWorkerSpy()
    
    sut.presenter = presenter
    sut.worker = worker
    
    // When
    let request = ListToDos.GetToDos.Request(date: Date())
    sut.requestToDos(request: request)
    
    // Then
    XCTAssertTrue(presenter.didPresentToDosCalled)
    XCTAssertTrue(worker.didRequestToDosCalled)
  }
  
  func testRequestToDosShouldSaveFetchedToDosInDataStore() throws {
    // Given
    let presenter = ListToDosPresentationLogicSpy()
    let worker = ListToDosWorkerSpy()
    
    sut.presenter = presenter
    sut.worker = worker
    
    // When
    let request = ListToDos.GetToDos.Request(date: Date())
    sut.requestToDos(request: request)
    
    // Then
    let todos = try XCTUnwrap(sut.todos)
    XCTAssertEqual(todos.count, 2)
    XCTAssertEqual(todos[0].id, 1)
    XCTAssertEqual(todos[0].title, "Title1")
    XCTAssertEqual(todos[0].content, "Content1")
    XCTAssertEqual(todos[1].id, 2)
    XCTAssertEqual(todos[1].title, "Title2")
    XCTAssertEqual(todos[1].content, "Content2")
  }
}
