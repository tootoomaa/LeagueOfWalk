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
    
    let mainSummonerVC = UINavigationController(rootViewController: MainSummonerVC())
    let randomItenVC = RandomItemVC()
    let userRankingVC = UserRankingVC()
    
    let tabBarController = UITabBarController()
    
    mainSummonerVC.tabBarItem = UITabBarItem(title: "Summoner", image: UIImage(systemName: "person.fill"), tag: 0)
    randomItenVC.tabBarItem = UITabBarItem(title: "Item", image: UIImage(systemName: "archivebox.fill"), tag: 1)
    userRankingVC.tabBarItem = UITabBarItem(title: "Ranking", image: UIImage(systemName: "person.3.fill"), tag: 2)
    
    UITabBar.appearance().barTintColor = CommonUI.pointColor
    
    tabBarController.viewControllers = [mainSummonerVC, randomItenVC, userRankingVC]
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.overrideUserInterfaceStyle = .dark
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
    
    return true
  }

}

