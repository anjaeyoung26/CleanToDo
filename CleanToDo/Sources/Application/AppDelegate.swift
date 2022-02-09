//
//  AppDelegate.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/09.
//

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = ListToDosViewController()
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    
    return true
  }
}

