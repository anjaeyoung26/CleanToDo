//
//  DetailToDoViewControllerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/24.
//

@testable import CleanToDo
import ViewControllerPresentationSpy
import Foundation
import XCTest

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
  
  func testDeleteToDoShouldCallRouterIfSuccess() {
    // Given
    let router = DetailToDoRouterSpy()
    sut.router = router
    
    loadView()
    
    // When
    let viewModel = DetailToDo.DeleteToDo.ViewModel(error: nil)
    sut.deleteToDo(viewModel: viewModel)
    
    // Then
    XCTAssertTrue(router.didRouteToListCalled)
  }
  
  func testDeleteToDoShouldCallDismissIfSuccess() {
    // Given
    let didDismiss = expectation(description: "Waiting for the deleteToDo() call to dismiss.")
    
    let dismissalVerifier = DismissalVerifier()
    dismissalVerifier.testCompletion = { didDismiss.fulfill() }
    
    loadView()
    
    // When
    let viewModel = DetailToDo.DeleteToDo.ViewModel(error: nil)
    sut.deleteToDo(viewModel: viewModel)
    
    waitForExpectations(timeout: 1.0)
    
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
    XCTAssertEqual(alertVerifier.presentingViewController, sut)
    XCTAssertEqual(alertVerifier.message, error.description)
    XCTAssertEqual(alertVerifier.title, "Delete Error")
    XCTAssertEqual(alertVerifier.actions.count, 1)
    XCTAssertEqual(alertVerifier.actions[0].title, "OK")
    XCTAssertEqual(alertVerifier.actions[0].style, .default)
    XCTAssertTrue(alertVerifier.animated)
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
    XCTAssertEqual(alertVerifier.presentingViewController, sut)
    XCTAssertEqual(alertVerifier.message, error.description)
    XCTAssertEqual(alertVerifier.title, "Update Error")
    XCTAssertEqual(alertVerifier.actions.count, 1)
    XCTAssertEqual(alertVerifier.actions[0].title, "OK")
    XCTAssertEqual(alertVerifier.actions[0].style, .default)
    XCTAssertTrue(alertVerifier.animated)
  }
}
