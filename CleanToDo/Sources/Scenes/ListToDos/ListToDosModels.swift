//
//  ListToDosModels.swift
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

enum ListToDos {
  enum GetToDos {
    struct Request {
      var date: Date
    }
    
    struct Response {
      var todos: [ToDo]?
    }
    
    struct ViewModel {
      var todos: [ToDo]?
    }
  }
}
