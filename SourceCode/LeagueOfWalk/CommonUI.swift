//
//  CommonUI.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit


struct CommonUI {
  
  // Colors
  
  static let backgroundColor: UIColor = UIColor(r: 17, g: 17, b: 17)
  static let pointColor: UIColor = UIColor(r: 6, g: 28, b: 37)
  static let edgeColor: UIColor = UIColor(r: 194, g: 143, b: 44)
  
  // Fonts
  
  enum CustonFonts: String {
    case koFont = "RixGoB"
    case enFont = "FrizQuadrataBold"
  }
  
  // Navigation Title
  
  enum NavigationBarTitle: String {
    case mainSummonerVC = "Summoner Info"
  }
  
}
