//
//  MainStatusCollectionViewCell.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/17.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class MainStatusCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "MainStatusCollectionViewCell"
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
