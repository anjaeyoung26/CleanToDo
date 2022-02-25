//
//  CreateToDoPresenterTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo
import XCTest

class CreateToDoPresenterTests: XCTestCase {
  private var sut: CreateToDoPresenter!
  
  override func setUp() {
    super.setUp()
    sut = CreateToDoPresenter()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testDidCreateToDoCalled() {
    // Given
    let viewController = CreateToDoDisplayLogicSpy()
    sut.viewController = viewController
    
    // When
    let response = CreateToDo.CreateToDo.Response(error: .alreadyExist)
    sut.createToDo(response: response)
    
    // Then
    XCTAssertTrue(viewController.didCreateTodoCalled)
    XCTAssertEqual(viewController.error, .alreadyExist)
  }
}
