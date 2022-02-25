//
//  DetailToDoRouter.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/09.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol DetailToDoRoutingLogic {
  func routeToList()
}

protocol DetailToDoDataPassing {
  var dataStore: DetailToDoDataStore? { get }
}

class DetailToDoRouter: NSObject, DetailToDoRoutingLogic, DetailToDoDataPassing {
  weak var viewController: DetailToDoViewController?
  var dataStore: DetailToDoDataStore?
  
  func routeToList() {
    
  }
}
