//
//  ListToDosRouterSpy.swift
//  CleanToDoTests
//
//  Created by 재영 on 2022/02/20.
//

@testable import CleanToDo
import Foundation

class ListToDosRouterSpy: NSObject, ListToDosRoutingLogic, ListToDosDataPassing {
  var didRouteToDetailCalled: Bool = false
  var dataStore: ListToDosDataStore?
  
  func routeToDetail() {
    didRouteToDetailCalled = true
  }
}
