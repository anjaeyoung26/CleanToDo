//
//  AlertFactory.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/25.
//

import Foundation
import UIKit

class AlertFactory {
  static func show(
    title: String? = nil,
    message: String? = nil,
    viewController: UIViewController,
    completion: (() -> Void)? = nil
  ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(.ok)
    
    DispatchQueue.main.async {
      viewController.present(alert, animated: true, completion: completion)
    }
  }
}

extension UIAlertAction {
  static var ok: UIAlertAction {
    return UIAlertAction(title: "OK", style: .default)
  }
}
