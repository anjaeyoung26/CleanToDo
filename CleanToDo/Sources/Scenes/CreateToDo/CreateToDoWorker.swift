//
//  CreateToDoWorker.swift
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

protocol CreateToDoWorkerLogic {
  func createToDo(_ todo: ToDo, completion: @escaping CreateCompletion)
}

class CreateToDoWorker: CreateToDoWorkerLogic {
  private var manager: ToDosCoreDataManager
  
  init() {
    manager = ToDosCoreDataManager(type: .persistent)
  }
  
  func createToDo(_ todo: ToDo, completion: @escaping CreateCompletion) {
    manager.createToDo(todo) { error, todo in
      completion(error, todo)
    }
  }
}
