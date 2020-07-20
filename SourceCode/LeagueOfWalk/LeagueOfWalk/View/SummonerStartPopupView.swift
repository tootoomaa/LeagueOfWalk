//
//  SummonerStartPopupView.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class SummonerStartPopupView: UIView {

  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "1-3")
    iv.contentMode = .scaleToFill
    iv.layer.borderWidth = CommonUI.borderWidth
    iv.layer.borderColor = CommonUI.edgeColor.cgColor
    
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = UIScreen.main.bounds
    self.backgroundColor = CommonUI.backgroundColor.withAlphaComponent(0.6)
    
    setUI()
  }

  private func setUI() {
    self.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
      $0.width.equalTo(self.frame.width / 1.5)
      $0.height.equalTo(self.frame.height / 1.5)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
