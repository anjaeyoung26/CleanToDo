//
//  ToDosCoreDataManagerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/09.
//

import CoreData
import XCTest
@testable import CleanToDo

class ToDosCoreDataManagerTests: XCTestCase {
  private var sut: ToDosCoreDataManagerProtocol!
  
  override func setUp() {
    super.setUp()
    
    sut = ToDosCoreDataManager(type: .inMemory)
    sut.createToDo(ToDo.fixture(id: 3)) { _, _ in }
    sut.createToDo(ToDo.fixture(id: 4)) { _, _ in }
  }
  
  override func tearDown() {
    sut.deleteAllToDos { _ in }
    sut = nil
    
    super.tearDown()
  }
  
  func testCreateToDo() {
    // Given
    let didContextSaveExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didCreateExpectation = expectation(description: "Waiting for the createToDo() call to create.")
    let fixture = ToDo.fixture(id: 1)
    
    var createdError: ToDosCoreDataManagerError!
    var createdToDo: ToDo!
    
    // When
    sut.createToDo(fixture) { error, todo in
      createdError = error
      createdToDo = todo
      didCreateExpectation.fulfill()
    }
    
    wait(for: [didCreateExpectation, didContextSaveExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(createdError)
    XCTAssertNotNil(createdToDo)
    XCTAssertEqual(createdToDo, fixture)
  }
  
  func testCreateToDoDuplicateId() {
    // Given
    let didErrorExpectation = expectation(description: "Waiting for the createToDo() call to receive error.")
    let fixture = ToDo.fixture(id: 3)
    
    var createdError: ToDosCoreDataManagerError!
    var createdToDo: ToDo!
    
    // When
    sut.createToDo(fixture) { error, todo in
      createdError = error
      createdToDo = todo
      didErrorExpectation.fulfill()
    }
    
    wait(for: [didErrorExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(createdToDo)
    XCTAssertNotNil(createdError)
    XCTAssertEqual(createdError, ToDosCoreDataManagerError.alreadyExist)
  }
  
  func testFetchToDo() {
    // Given
    let didFetchExpectation = expectation(description: "Waiting for the fetchToDo() call to fetch exisiting ToDo.")
    
    var fetchedToDo: ToDo!
    
    // When
    sut.fetchToDo(id: 3) { todo in
      fetchedToDo = todo
      didFetchExpectation.fulfill()
    }
    
    wait(for: [didFetchExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNotNil(fetchedToDo)
    XCTAssertEqual(fetchedToDo.id, 3)
  }
  
  func testFetchNonExistingToDo() {
    // Given
    let didNotFetchExpectation = expectation(description: "Waiting for the fetchToDo() call to fetch non-exisiting ToDo")
    
    var fetchedToDo: ToDo!
    
    // Then
    sut.fetchToDo(id: 5) { todo in
      fetchedToDo = todo
      didNotFetchExpectation.fulfill()
    }
    
    wait(for: [didNotFetchExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(fetchedToDo)
  }
  
  func testUpdateToDo() {
    // Given
    let didContextSaveExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didUpdateExpectation = expectation(description: "Waiting for the updateToDo() call to update existing ToDo.")
    let fixture = ToDo.fixture(id: 3, title: "Update")
    
    var updatedError: ToDosCoreDataManagerError!
    var updatedToDo: ToDo!
    
    // When
    sut.updateToDo(fixture) { error, todo in
      updatedError = error
      updatedToDo = todo
      didUpdateExpectation.fulfill()
    }
    
    wait(for: [didUpdateExpectation, didContextSaveExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(updatedError)
    XCTAssertNotNil(updatedToDo)
    XCTAssertEqual(updatedToDo.id, 3)
    XCTAssertEqual(updatedToDo.title, "Update")
  }
  
  func testUpdateNonExistingToDo() {
    // Given
    let didNotUpdateExpectation = expectation(description: "Waiting for the updateToDo() call to update non-existing ToDo.")
    let fixture = ToDo.fixture(id: 10)
    
    var updatedError: ToDosCoreDataManagerError!
    var updatedToDo: ToDo!
    
    // When
    sut.updateToDo(fixture) { error, todo in
      updatedError = error
      updatedToDo = todo
      didNotUpdateExpectation.fulfill()
    }
    
    wait(for: [didNotUpdateExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(updatedToDo)
    XCTAssertNotNil(updatedError)
    XCTAssertEqual(updatedError, ToDosCoreDataManagerError.notExist)
  }
  
  func testDeleteToDo() {
    // Given
    let didContextSaveExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didDeleteExpectation = expectation(description: "Waiting for the deleteToDo() call to delete exisiting ToDo.")
    
    var deletedError: ToDosCoreDataManagerError!
    
    // When
    sut.deleteToDo(id: 3) { error in
      deletedError = error
      didDeleteExpectation.fulfill()
    }
    
    wait(for: [didDeleteExpectation, didContextSaveExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNil(deletedError)
  }
  
  func testDeleteNonExistingToDo() {
    // Given
    let didErrorExpectation = expectation(description: "Waiting for the deleteToDo() call to delete non-exisiting ToDo and return error.")
    
    var deletedError: ToDosCoreDataManagerError!
    
    // When
    sut.deleteToDo(id: 6) { error in
      deletedError = error
      didErrorExpectation.fulfill()
    }
    
    wait(for: [didErrorExpectation], timeout: 1.0)
    
    // Then
    XCTAssertNotNil(deletedError)
    XCTAssertEqual(deletedError, ToDosCoreDataManagerError.notExist)
  }
}
