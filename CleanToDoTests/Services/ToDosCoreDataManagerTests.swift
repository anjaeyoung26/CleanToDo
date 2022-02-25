//
//  ToDosCoreDataManagerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/09.
//

@testable import CleanToDo
import CoreData
import XCTest

class ToDosCoreDataManagerTests: XCTestCase {
  private var sut: ToDosCoreDataManagerProtocol!
  
  override func setUp() {
    super.setUp()
    
    sut = ToDosCoreDataManager(type: .inMemory)
    createStubs()
  }
  
  override func tearDown() {
    sut.deleteAllToDos { _ in }
    sut = nil
    
    super.tearDown()
  }
  
  func createStubs() {
    sut.createToDo(ToDo.fixture(id: 3)) { _, _ in }
    sut.createToDo(ToDo.fixture(id: 4)) { _, _ in }
  }
  
  func testCreateToDo() {
    // Given
    expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didCreate = expectation(description: "Waiting for the createToDo() call to create.")
    let fixture = ToDo.fixture(id: 1)
    
    var createdError: ToDosCoreDataManagerError!
    var createdToDo: ToDo!
    
    // When
    sut.createToDo(fixture) { error, todo in
      createdError = error
      createdToDo = todo
      didCreate.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(createdError)
    XCTAssertNotNil(createdToDo)
    XCTAssertEqual(createdToDo, fixture)
  }
  
  func testCreateToDoDuplicateId() {
    // Given
    let didError = expectation(description: "Waiting for the createToDo() call to receive error.")
    let fixture = ToDo.fixture(id: 3)
    
    var createdError: ToDosCoreDataManagerError!
    var createdToDo: ToDo!
    
    // When
    sut.createToDo(fixture) { error, todo in
      createdError = error
      createdToDo = todo
      didError.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(createdToDo)
    XCTAssertNotNil(createdError)
    XCTAssertEqual(createdError, ToDosCoreDataManagerError.alreadyExist)
  }
  
  func testFetchToDo() {
    // Given
    let didFetch = expectation(description: "Waiting for the fetchToDo() call to fetch exisiting ToDo.")
    
    var fetchedToDo: ToDo!
    
    // When
    sut.fetchToDo(id: 3) { todo in
      fetchedToDo = todo
      didFetch.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNotNil(fetchedToDo)
    XCTAssertEqual(fetchedToDo.id, 3)
  }
  
  func testFetchNonExistingToDo() {
    // Given
    let didNotFetch = expectation(description: "Waiting for the fetchToDo() call to fetch non-exisiting ToDo")
    
    var fetchedToDo: ToDo!
    
    // Then
    sut.fetchToDo(id: 5) { todo in
      fetchedToDo = todo
      didNotFetch.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(fetchedToDo)
  }
  
  func testFetchToDosDateNothingStored() {
    // Given
    let didNotFetch = expectation(description: "Waiting for the fetchToDos() call to fetch non-existing ToDos.")
    let yesterday = Date(timeIntervalSinceNow: -86400)
    
    var fetchedToDos: [ToDo]!
    
    // When
    sut.fetchToDos(date: yesterday) { todos in
      fetchedToDos = todos
      didNotFetch.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertEqual(fetchedToDos, [])
  }
  
  func testFetchToDosDateTwoCreated() {
    // Given
    let didFetch = expectation(description: "Waiting for the fetchToDos() call to fetch existing ToDos.")
    let today = Date()
    
    var fetchedToDos: [ToDo]!
    
    // When
    sut.fetchToDos(date: today) { todos in
      fetchedToDos = todos
      didFetch.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNotNil(fetchedToDos)
    XCTAssertEqual(fetchedToDos.count, 2)
  }
  
  func testUpdateToDo() {
    // Given
    expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didUpdate = expectation(description: "Waiting for the updateToDo() call to update existing ToDo.")
    let fixture = ToDo.fixture(id: 3, title: "Update")
    
    var updatedError: ToDosCoreDataManagerError!
    var updatedToDo: ToDo!
    
    // When
    sut.updateToDo(fixture) { error, todo in
      updatedError = error
      updatedToDo = todo
      didUpdate.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(updatedError)
    XCTAssertNotNil(updatedToDo)
    XCTAssertEqual(updatedToDo.id, 3)
    XCTAssertEqual(updatedToDo.title, "Update")
  }
  
  func testUpdateNonExistingToDo() {
    // Given
    let didNotUpdate = expectation(description: "Waiting for the updateToDo() call to update non-existing ToDo.")
    let fixture = ToDo.fixture(id: 10)
    
    var updatedError: ToDosCoreDataManagerError!
    var updatedToDo: ToDo!
    
    // When
    sut.updateToDo(fixture) { error, todo in
      updatedError = error
      updatedToDo = todo
      didNotUpdate.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(updatedToDo)
    XCTAssertNotNil(updatedError)
    XCTAssertEqual(updatedError, ToDosCoreDataManagerError.notExist)
  }
  
  func testDeleteToDo() {
    // Given
    expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context) { _ in return true }
    let didDelete = expectation(description: "Waiting for the deleteToDo() call to delete exisiting ToDo.")
    
    var deletedError: ToDosCoreDataManagerError!
    
    // When
    sut.deleteToDo(id: 3) { error in
      deletedError = error
      didDelete.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNil(deletedError)
  }
  
  func testDeleteNonExistingToDo() {
    // Given
    let didError = expectation(description: "Waiting for the deleteToDo() call to delete non-exisiting ToDo and return error.")
    
    var deletedError: ToDosCoreDataManagerError!
    
    // When
    sut.deleteToDo(id: 6) { error in
      deletedError = error
      didError.fulfill()
    }
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNotNil(deletedError)
    XCTAssertEqual(deletedError, ToDosCoreDataManagerError.notExist)
  }
}
