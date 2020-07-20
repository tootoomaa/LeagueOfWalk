//
//  CommonUI.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit


struct CommonUI {
  
  // Radius, borderWidth
  
  static let cornerRadius: CGFloat = 14
  static let borderWidth: CGFloat = 0.45
  
  // Colors
  
  static let backgroundColor: UIColor = UIColor(r: 17, g: 17, b: 17)
  static let pointColor: UIColor = UIColor(r: 6, g: 28, b: 37)
  static let edgeColor: UIColor = UIColor(r: 194, g: 143, b: 44)
  
  // Fonts
  
  enum CustonFonts: String {
    case koFont = "RixGoB"
    case koFontRegular = "RixGoL"
    case enFont = "FrizQuadrataBold"
    case enFontRagular = "FrizQua-ReguOS"
  }
  
  // Font Size
  
  enum FontSize: CGFloat {
    case Large = 22.5
    case Medium = 17.5
    case small = 13.5
  }
  
  // SFSymbol
  
  enum SFSymbolKey: String {
    case main = "rosette"
  }
  
  // Navigation Title
  
  enum NavigationBarTitle: String {
    case mainSummonerVC = "SUMMONER"
    case itemListVC = "ITEM LIST"
    case rankingVC = "RANKING"
    case profileVC = "PROFILE"
  }
  
}


struct Standard {
  static let textColor: UIColor = UIColor.init(red: 0.68417418, green: 0.6511475444, blue: 0.4992383122, alpha: 1)
  static let padding: CGFloat = 20
  static let smallPadding: CGFloat = 5
  static let buttonHeight: CGFloat = 50
  static let textSize: CGFloat = 15
  static let myEdgeInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
}
