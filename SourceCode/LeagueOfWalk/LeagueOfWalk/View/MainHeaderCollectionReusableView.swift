//
//  MainHeaderCollectionReusableView.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
  
  static let identifier = "MainHeaderCollectionReusableView"
  private let headerLabel: UILabel = {
    let label = UILabel()
    label.text = "IMAGE SPACE"
    label.font = UIFont(name: CommonUI.CustonFonts.enFont.rawValue, size: CommonUI.FontSize.Large.rawValue)
    label.textColor = .white
    
    return label
  }()
  private let heroImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Egg")
    
    return imageView
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    self.addSubview(heroImageView)
    
    heroImageView.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
