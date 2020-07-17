//
//  MainFooterCollectionReusableView.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/17.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainFooterCollectionReusableView: UICollectionReusableView {
        
  static let identifier = "MainFooterCollectionReusableView"
  
  private let label: UILabel = {
    let label = UILabel()
    label.text = "Contents"
    
    return label
  }()
  
  private let contentsView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.pointColor
    view.layer.cornerRadius = CommonUI.cornerRadius
    view.layer.borderWidth = CommonUI.borderWidth
    view.layer.borderColor = CommonUI.edgeColor.cgColor
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
    self.addSubview(label)
    [contentsView, label].forEach {
      self.addSubview($0)
    }
    
    contentsView.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.trailing.equalTo(self).offset(-15)
      $0.bottom.equalTo(self)
      $0.leading.equalTo(self).offset(15)
    }
    
    label.snp.makeConstraints {
      $0.centerX.centerY.equalTo(contentsView)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
          
}
