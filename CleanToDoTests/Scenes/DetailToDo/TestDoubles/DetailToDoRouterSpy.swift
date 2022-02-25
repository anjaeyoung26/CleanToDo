//
//  DetailToDoRouterSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/24.
//

import Foundation
@testable import CleanToDo

class DetailToDoRouterSpy: NSObject, DetailToDoRoutingLogic, DetailToDoDataPassing {
  public var didRouteToListCalled: Bool = false
  public var dataStore: DetailToDoDataStore?
  
  func routeToList() {
    didRouteToListCalled = true
  }
}
