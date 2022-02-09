//
//  CreateToDoPresenter.swift
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

protocol CreateToDoPresentationLogic
{
  func presentSomething(response: CreateToDo.Something.Response)
}

class CreateToDoPresenter: CreateToDoPresentationLogic
{
  weak var viewController: CreateToDoDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CreateToDo.Something.Response)
  {
    let viewModel = CreateToDo.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
