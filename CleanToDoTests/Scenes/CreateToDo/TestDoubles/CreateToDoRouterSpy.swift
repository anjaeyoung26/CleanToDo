//
//  CreateToDoRouterSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

@testable import CleanToDo
import Foundation

class CreateToDoRouterSpy: NSObject, CreateToDoRoutingLogic, CreateToDoDataPassing {
  var didRouteToListCalled: Bool = false
  var dataStore: CreateToDoDataStore?
  
  func routeToList() {
    didRouteToListCalled = true
  }
}
