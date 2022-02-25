//
//  ListToDosViewControllerTests.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/18.
//

import XCTest
@testable import CleanToDo

class ListToDosViewControllerTests: XCTestCase {
  private var sut: ListToDosViewController!
  private var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    
    sut = ListToDosViewController()
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
  
  func testWhenViewWillAppearShouldCallRequestToDos() {
    // Given
    let interactor = ListToDosBusinessLogicSpy()
    sut.interactor = interactor
    
    loadView()
    
    // When
    sut.viewWillAppear(true)
    
    // Then
    XCTAssertTrue(interactor.didRequestToDosCalled)
  }
  
  func testDisplayFetchedToDosInTableView() {
    // Given
    loadView()
    
    // When
    let fixtures = [ToDo.fixture(id: 1, title: "Title", content: "Content")]
    let viewModel = ListToDos.GetToDos.ViewModel(todos: fixtures)
    sut.displayToDos(viewModel: viewModel)
    
    // Then
    let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ListToDosCell
    
    XCTAssertEqual(cell.titleLabel.text, "Title")
    XCTAssertEqual(cell.contentLabel.text, "Content")
  }
  
  func testRouterShouldPassSelectedToDo() {
    // Given
    let router = ListToDosRouterSpy()
    sut.router = router
    
    sut.todos = [
      ToDo.fixture(id: 1),
      ToDo.fixture(id: 2)
    ]
    
    loadView()
    
    // When
    sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
    // Then
    XCTAssertTrue(router.didRouteToDetailCalled)
  }
}
