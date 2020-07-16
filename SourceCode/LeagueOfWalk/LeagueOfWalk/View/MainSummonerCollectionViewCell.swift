//
//  MainSummonerCollectionViewCell.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainSummonerCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "MainSummonerCollectionViewCell"
  
  var item: String? {
    didSet {
      self.textLabel.text = item
    }
  }
  
  lazy var textLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = CommonUI.pointColor
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    self.addSubview(textLabel)

    textLabel.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
