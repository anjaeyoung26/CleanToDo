//
//  DetailToDoRouterSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/24.
//

@testable import CleanToDo
import Foundation

class DetailToDoRouterSpy: NSObject, DetailToDoRoutingLogic, DetailToDoDataPassing {
  var didRouteToListCalled: Bool = false
  var dataStore: DetailToDoDataStore?
  
  func routeToList() {
    didRouteToListCalled = true
  }
}
