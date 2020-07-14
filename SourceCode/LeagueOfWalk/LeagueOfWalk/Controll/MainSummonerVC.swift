//
//  MainSummonerVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class MainSummonerVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "title"
    navigationSettings()
    
    view.backgroundColor = CommonUI.backgroundColor
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
