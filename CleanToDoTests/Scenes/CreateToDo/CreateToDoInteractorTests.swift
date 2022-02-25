//
//  CreateToDoInteractorTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo
import XCTest

class CreateToDoInteractorTests: XCTestCase {
  private var sut: CreateToDoInteractor!
  
  override func setUp() {
    super.setUp()
    sut = CreateToDoInteractor()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testCreateToDoShouldCallPresenter() {
    // Given
    let presenter = CreateToDoPresentationSpy()
    let worker = CreateToDoWorkerSpy()
    
    sut.presenter = presenter
    sut.worker = worker
    
    // When
    let fixture = ToDo.fixture(id: 1)
    let request = CreateToDo.CreateToDo.Request(todo: fixture)
    sut.createToDo(request: request)
    
    // Then
    XCTAssertTrue(presenter.didCreateToDoCalled)
    XCTAssertTrue(worker.didCreateToDoCalled)
  }
}
