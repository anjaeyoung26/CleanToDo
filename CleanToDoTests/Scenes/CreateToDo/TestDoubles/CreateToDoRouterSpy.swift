//
//  CreateToDoRouterSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/25.
//

import Foundation
@testable import CleanToDo

class CreateToDoRouterSpy: NSObject, CreateToDoRoutingLogic, CreateToDoDataPassing {
  var didRouteToListCalled: Bool = false
  var dataStore: CreateToDoDataStore?
  
  func routeToList() {
    didRouteToListCalled = true
  }
}
