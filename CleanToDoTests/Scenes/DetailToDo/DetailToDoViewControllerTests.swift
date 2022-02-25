//
//  DetailToDoViewControllerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/24.
//

import ViewControllerPresentationSpy

import Foundation
import XCTest
@testable import CleanToDo

class DetailToDoViewControllerTests: XCTestCase {
  private var sut: DetailToDoViewController!
  private var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    
    sut = DetailToDoViewController()
    window = UIWindow()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  func testWhenViewDidLoadShouldSetup() {
    // Given
    loadView()
    
    // When
    sut.viewDidLoad()
    
    // Then
    XCTAssertNotNil(sut.interactor)
    XCTAssertNotNil(sut.router)
  }
  
  func testWhenViewWillAppearShouldCallRequestToDo() {
    // Given
    let interactor = DetailToDoBusinessLogicSpy()
    sut.interactor = interactor
    
    loadView()
    
    // When
    sut.viewWillAppear(true)
    
    // Then
    XCTAssertTrue(interactor.didGetToDoCalled)
  }
  
  func testWhenDeleteButtonTappedShouldCallDeleteToDo() {
    // Given
    let interactor = DetailToDoBusinessLogicSpy()
    sut.interactor = interactor
    
    loadView()
    
    // When
    sut.deleteButton.sendActions(for: .touchUpInside)
    
    // Then
    XCTAssertTrue(interactor.didDeleteToDoCalled)
  }
  
  func testGetToDoShouldDisplayLabels() {
    // Given
    loadView()
    
    // When
    let viewModel = DetailToDo.GetToDo.ViewModel(todo: ToDo.fixture(id: 1))
    sut.displayToDo(viewModel: viewModel)
    
    // Then
    XCTAssertEqual(sut.todo, viewModel.todo)
    XCTAssertEqual(sut.titleLabel.text, viewModel.todo.title)
    XCTAssertEqual(sut.contentLabel.text, viewModel.todo.content)
  }
  
  func testDeleteToDoShouldCallDismissIfSuccess() {
    // Given
    let dismissalVerifier = DismissalVerifier()
    loadView()
    
    // When
    let viewModel = DetailToDo.DeleteToDo.ViewModel(error: nil)
    sut.deleteToDo(viewModel: viewModel)
    
    // Then
    dismissalVerifier.verify(animated: true, dismissedViewController: sut)
  }
  
  func testDeleteToDoShouldPresentAlertIfFail() {
    // Given
    let didPresent = expectation(description: "Waiting for the deleteToDo(viewModel:) call to present alert.")
    
    let alertVerifier = AlertVerifier()
    alertVerifier.testCompletion = { didPresent.fulfill() }
    
    loadView()
    
    // When
    let error = ToDosCoreDataManagerError.notExist
    let viewModel = DetailToDo.DeleteToDo.ViewModel(error: error)
    sut.deleteToDo(viewModel: viewModel)
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    alertVerifier.verify(
      title: "Delete Error",
      message: error.description,
      animated: true,
      actions: [.default("OK")],
      presentingViewController: sut
    )
  }
  
  func testUpdateToDoShouldUpdateIfSuccess() {
    // Given
    loadView()
    
    // When
    let fixture = ToDo.fixture(id: 1)
    let viewModel = DetailToDo.UpdateToDo.ViewModel(todo: fixture)
    sut.updateToDo(viewModel: viewModel)
    
    // Then
    XCTAssertEqual(sut.todo, fixture)
  }
  
  func testUpdateToDoShouldPresentAlertIfFail() {
    // Given
    let didPresent = expectation(description: "Waiting for the updateToDo(viewModel:) call to present alert.")
    
    let alertVerifier = AlertVerifier()
    alertVerifier.testCompletion = { didPresent.fulfill() }
    
    loadView()
    
    // When
    let error = ToDosCoreDataManagerError.notExist
    let viewModel = DetailToDo.UpdateToDo.ViewModel(error: error)
    sut.updateToDo(viewModel: viewModel)
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    alertVerifier.verify(
      title: "Update Error",
      message: error.description,
      animated: true,
      actions: [.default("OK")],
      presentingViewController: sut
    )
  }
}
