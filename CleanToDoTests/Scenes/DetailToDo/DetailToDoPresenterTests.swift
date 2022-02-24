//
//  DetailToDoPresenterTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/23.
//

import XCTest
@testable import CleanToDo

class DetailToDoPresenterTests: XCTestCase {
  private var sut: DetailToDoPresenter!
  
  override func setUp() {
    super.setUp()
    sut = DetailToDoPresenter()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testDidDisplayToDoCalled() {
    // Given
    let viewController = DetailToDoDisplayLogicSpy()
    sut.viewController = viewController
    
    // When
    let response = DetailToDo.GetToDo.Response(todo: ToDo.fixture(id: 1))
    sut.presentToDo(response: response)
    
    // Then
    XCTAssertTrue(viewController.didDisplayToDoCalled)
    XCTAssertEqual(viewController.todo, response.todo)
  }
  
  func testDidDeleteToDoCalled() {
    // Given
    let viewController = DetailToDoDisplayLogicSpy()
    sut.viewController = viewController
    
    // When
    let response = DetailToDo.DeleteToDo.Response()
    sut.deleteToDo(response: response)
    
    // Then
    XCTAssertTrue(viewController.didDeleteToDoCalled)
    XCTAssertNil(viewController.todo)
  }
  
  func testDidUpdateToDoCalled() {
    // Given
    let viewController = DetailToDoDisplayLogicSpy()
    sut.viewController = viewController
    
    // When
    let response = DetailToDo.UpdateToDo.Response()
    sut.updateToDo(response: response)
    
    // Then
    XCTAssertTrue(viewController.didUpdateToDoCalled)
    XCTAssertEqual(viewController.todo, response.todo)
  }
}
