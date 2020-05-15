//
//  AppDelegate.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     var window: UIWindow?
      
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          // Override point for customization after application launch.
          window = UIWindow(frame: UIScreen.main.bounds)
                let rootVC = EmployeeListViewController()
                let rootNC = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = rootNC
                window?.makeKeyAndVisible()

                return true
      }
}

