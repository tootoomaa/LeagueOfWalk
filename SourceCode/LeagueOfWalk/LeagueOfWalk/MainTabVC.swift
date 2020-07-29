//
//  MainTabVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    
    checkIfUserIsLoggedIn()
    
  }
  
  func configureTabBar() {
    
    let mainViewController = UINavigationController(rootViewController: MainViewController())
    let randomItenVC = UINavigationController(rootViewController: RandomItemVC())
    let userRankingVC = UINavigationController(rootViewController: UserRankingVC())
    let profileVC = UINavigationController(rootViewController: ProfileVC())
    
    mainViewController.tabBarItem = UITabBarItem(title: "Summoner", image: UIImage(systemName: CommonUI.SFSymbolKey.main.rawValue), tag: 0)
    randomItenVC.tabBarItem = UITabBarItem(title: "Item", image: UIImage(systemName: "archivebox.fill"), tag: 1)
    userRankingVC.tabBarItem = UITabBarItem(title: "Ranking", image: UIImage(systemName: "person.3.fill"), tag: 2)
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
    
    UITabBar.appearance().barTintColor = CommonUI.pointColor
    UITabBar.appearance().tintColor = CommonUI.edgeColor
    
    viewControllers = [mainViewController, randomItenVC, userRankingVC, profileVC]
  }
  
  // Construct new controller
  func constructNavController(unselectedImage:UIImage, selectedImage:UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    
    // Construct nav controller
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.image = unselectedImage
    navController.tabBarItem.selectedImage = selectedImage
    navController.navigationBar.tintColor = .black
    
    // return new Controller
    return navController
  }
  
  func checkIfUserIsLoggedIn() {
    DispatchQueue.main.async {
      print(Auth.auth().currentUser)
      if Auth.auth().currentUser == nil {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
      }
    }
  }
}

