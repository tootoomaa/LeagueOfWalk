//
//  RandomItemVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class RandomItemVC: UIViewController {
  
  lazy var logoutButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(logoutButton)
    
    logoutButton.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
    
    
  }
  
  @objc func handleLogoutButton() {
    do {
      // attemp sign out
      try Auth.auth().signOut()
      
      //present login controller
      let loginVC = LoginVC()
      let navController = UINavigationController(rootViewController: loginVC)
      navController.modalPresentationStyle = .fullScreen
      self.present(navController, animated: true, completion: nil)
      print("SucessFull Log out User")
    } catch {
      //handle erorr
      print("Failed to sign out")
    }
  }
  
}
