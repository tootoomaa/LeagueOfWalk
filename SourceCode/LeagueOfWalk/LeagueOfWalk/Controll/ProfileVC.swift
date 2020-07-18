//
//  ProfileVC.swift
//  LeagueOfWalk
//
//  Created by 표건욱 on 2020/07/17.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
