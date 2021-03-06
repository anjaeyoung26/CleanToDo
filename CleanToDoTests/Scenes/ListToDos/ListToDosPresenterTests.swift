//
//  ListToDosPresenterTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/17.
//

@testable import CleanToDo
import XCTest

class ListToDosPresenterTests: XCTestCase {
  private var sut: ListToDosPresenter!
  
  override func setUp() {
    super.setUp()
    sut = ListToDosPresenter()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testDidDisplayToDosCalled() {
    // Given
    let viewController = ListToDosDisplayLogicSpy()
    sut.viewController = viewController
    
    let fixture = ToDo.fixture(id: 1)
    
    // When
    let response = ListToDos.GetToDos.Response(todos: [fixture])
    sut.presentToDos(response: response)
    
    // Then
    XCTAssertTrue(viewController.didDisplayToDosCalled)
  }
  
  func testPresentFetchedToDosShouldEqualDisplayedToDos() throws {
    // Given
    let viewController = ListToDosDisplayLogicSpy()
    sut.viewController = viewController
    
    let today = Date()
    let tomorrow = Date(timeIntervalSinceNow: +86400)
    
    let fixture = ToDo.fixture(
      id: 1,
      title: "Title",
      content: "Content",
      startDate: today,
      dueDate: tomorrow
    )
    
    // When
    let response = ListToDos.GetToDos.Response(todos: [fixture])
    sut.presentToDos(response: response)
    
    // Then
    for todo in viewController.todos {
      XCTAssertEqual(todo.id, 1)
      XCTAssertEqual(todo.title, "Title")
      XCTAssertEqual(todo.content, "Content")
      XCTAssertEqual(todo.startDate, today)
      XCTAssertEqual(todo.dueDate, tomorrow)
    }
  }
}
