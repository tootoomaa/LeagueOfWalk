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
  private let heroImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Egg")
    
    return imageView
  }()
  
  private let openButton: UIButton = {
    let button = UIButton()
    button.setTitle("눌러서 확인하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTabOpenButton), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - LifeCycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
    openButton.titleLabel?.font = UIFont(
      name: CommonUI.CustonFonts.koFont.rawValue,
      size: 20
    )
    
    [heroImageView, openButton].forEach {
      self.addSubview($0)
    }
    heroImageView.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
    openButton.snp.makeConstraints {
      $0.bottom.equalTo(heroImageView)
      $0.centerX.equalTo(heroImageView)
    }
  }
  
  // MARK: - Action
  
  @objc private func didTabOpenButton() {
    print("Open")
    // Open Animation
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
