//
//  DetailToDoPresenter.swift
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

protocol DetailToDoPresentationLogic {
  func presentToDo(response: DetailToDo.GetToDo.Response)
  func deleteToDo(response: DetailToDo.DeleteToDo.Response)
  func updateToDo(response: DetailToDo.UpdateToDo.Response)
}

class DetailToDoPresenter: DetailToDoPresentationLogic {
  weak var viewController: DetailToDoDisplayLogic?
  
  func presentToDo(response: DetailToDo.GetToDo.Response) {
    let viewModel = DetailToDo.GetToDo.ViewModel(todo: response.todo)
    viewController?.displayToDo(viewModel: viewModel)
  }
  
  func deleteToDo(response: DetailToDo.DeleteToDo.Response) {
    let viewModel = DetailToDo.DeleteToDo.ViewModel(error: response.error)
    viewController?.deleteToDo(viewModel: viewModel)
  }
  
  func updateToDo(response: DetailToDo.UpdateToDo.Response) {
    let viewModel = DetailToDo.UpdateToDo.ViewModel(error: response.error, todo: response.todo)
    viewController?.updateToDo(viewModel: viewModel)
  }
}
