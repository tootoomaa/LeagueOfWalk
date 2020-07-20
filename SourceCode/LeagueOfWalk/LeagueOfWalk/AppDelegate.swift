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
    
    let mainViewController = UINavigationController(rootViewController: MainViewController() )
    let randomItenVC = UINavigationController(rootViewController: RandomItemVC())
    let userRankingVC = UINavigationController(rootViewController: UserRankingVC())
    let profileVC = UINavigationController(rootViewController: ProfileVC())
    
    let tabBarController = UITabBarController()
    
    mainViewController.tabBarItem = UITabBarItem(title: "Summoner", image: UIImage(systemName: CommonUI.SFSymbolKey.main.rawValue), tag: 0)
    randomItenVC.tabBarItem = UITabBarItem(title: "Item", image: UIImage(systemName: "archivebox.fill"), tag: 1)
    userRankingVC.tabBarItem = UITabBarItem(title: "Ranking", image: UIImage(systemName: "person.3.fill"), tag: 2)
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
    
    
    UITabBar.appearance().barTintColor = CommonUI.pointColor
    UITabBar.appearance().tintColor = CommonUI.edgeColor
    
    tabBarController.viewControllers = [mainViewController, randomItenVC, userRankingVC, profileVC]
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.overrideUserInterfaceStyle = .dark
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }

}

