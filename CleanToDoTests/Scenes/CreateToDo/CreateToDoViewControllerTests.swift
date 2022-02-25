//
//  CreateToDoViewControllerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo
import ViewControllerPresentationSpy
import XCTest

class CreateToDoViewControllerTests: XCTestCase {
  private var sut: CreateToDoViewController!
  private var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    
    sut = CreateToDoViewController()
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
  
  func testCreateToDoShouldCallRouterIfSuccess() {
    // Given
    let router = CreateToDoRouterSpy()
    sut.router = router
    
    loadView()
    
    // When
    let viewModel = CreateToDo.CreateToDo.ViewModel(error: nil)
    sut.createToDo(viewModel: viewModel)
    
    // Then
    XCTAssertTrue(router.didRouteToListCalled)
  }
  
  func testCreateToDoShouldCallDismissIfSuccess() {
    // Given
    let didDismiss = expectation(description: "Waiting for the createToDo(viewModel:) call to dismiss.")
    
    let dismissalVerifier = DismissalVerifier()
    dismissalVerifier.testCompletion = { didDismiss.fulfill() }
    
    loadView()
    
    // When
    let viewModel = CreateToDo.CreateToDo.ViewModel(error: nil)
    sut.createToDo(viewModel: viewModel)
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    dismissalVerifier.verify(animated: true, dismissedViewController: sut)
  }
  
  func testCreateToDoShouldPresentAlertIfFail() {
    // Given
    let didPresent = expectation(description: "Waiting for the createToDo(viewModel:) call to present alert.")
    
    let alertVerifier = AlertVerifier()
    alertVerifier.testCompletion = { didPresent.fulfill() }
    
    loadView()
    
    // When
    let error = ToDosCoreDataManagerError.alreadyExist
    let viewModel = CreateToDo.CreateToDo.ViewModel(error: error)
    sut.createToDo(viewModel: viewModel)
    
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertEqual(alertVerifier.presentingViewController, sut)
    XCTAssertEqual(alertVerifier.message, error.description)
    XCTAssertEqual(alertVerifier.title, "Create Error")
    XCTAssertEqual(alertVerifier.actions.count, 1)
    XCTAssertEqual(alertVerifier.actions[0].title, "OK")
    XCTAssertEqual(alertVerifier.actions[0].style, .default)
    XCTAssertTrue(alertVerifier.animated)
  }
}
