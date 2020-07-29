//
//  AppDelegate.swift
//  LeagueOfWork
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.overrideUserInterfaceStyle = .dark
    window?.rootViewController = MainTabVC()
    window?.makeKeyAndVisible()
    
    return true
  }

}

