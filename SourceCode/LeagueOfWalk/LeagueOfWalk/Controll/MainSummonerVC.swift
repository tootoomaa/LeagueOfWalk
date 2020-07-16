//
//  MainSummonerVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class MainSummonerVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "title"
    
    view.backgroundColor = CommonUI.backgroundColor
    
    navigationSettings()
    
    // 로그인 상태 확인
    checkIfUserIsLoggedIn()
    
    // 케릭터 선택 여부 확인
    checkIfUserSelectCharacter()
    
    
  }
  
  func checkIfUserIsLoggedIn() {
    DispatchQueue.main.async {
      if Auth.auth().currentUser == nil {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
      }
    }
  }
  
  func checkIfUserSelectCharacter() {
    DispatchQueue.main.async {
      if let uid = Auth.auth().currentUser?.uid {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
          print(snapshot)
          
          guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
          
          let user = User.init(uid: uid, dictionary: dictionary)
          
          if user.selectCharactor == "" {
            let selectCharVC = SelectCharVC()
            selectCharVC.userData = user
            selectCharVC.modalPresentationStyle = .fullScreen
            self.present(selectCharVC, animated: true, completion: nil)
          }
        }
      }
    }
  }
}

extension MainSummonerVC {
  func navigationSettings() {
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: "title"
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
    
    tabBarController?.tabBar.tintColor = CommonUI.edgeColor
  }
}
