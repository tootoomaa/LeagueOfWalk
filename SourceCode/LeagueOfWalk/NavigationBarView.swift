//
//  NavigationBarView.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class NavigationBarView: UIView {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: CommonUI.CustonFonts.enFont.rawValue, size: CommonUI.FontSize.Large.rawValue)
    label.textColor = CommonUI.edgeColor
    return label
  }()

  
  // MARK: - LifeCycle
  
  init(frame: CGRect, title: String) {
    super.init(frame: frame)
    
    setUI(with: title)
  }
  
  // MARK: - Layout
  
  private func setUI(with title: String) {
    titleLabel.text = title
    
    [titleLabel].forEach {
      self.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
