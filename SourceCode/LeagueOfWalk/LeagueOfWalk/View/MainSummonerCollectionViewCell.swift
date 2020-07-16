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
  
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Boots")
    
    return imageView
  }()
  
  private let contentsTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(
      name: CommonUI.CustonFonts.enFontRagular.rawValue,
      size: CommonUI.FontSize.small.rawValue
    )
    
    label.text = "ToDay Day Walk"
    
    return label
  }()
  
  private let walkProgressView: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .bar)
    progressView.progress = .infinity
//    progressView.tintColor = .none
    progressView.layer.cornerRadius = CommonUI.cornerRadius
    
    return progressView
  }()
  
  private let progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = CommonUI.pointColor
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    UIView.animate(withDuration: 4.0) {
        self.walkProgressView.setProgress(1.0, animated: true)
    }
    
    let layer = CAGradientLayer()
    layer.frame = self.frame
    layer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
    layer.colors = [UIColor(rgb:0xf1e7fe).cgColor, UIColor(rgb: 0xbe90d4).cgColor]
    layer.locations = [0, 1]
    walkProgressView.layer.addSublayer(layer)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
    [textLabel, iconImageView, contentsTitle, progressView].forEach {
      self.addSubview($0)
    }

    textLabel.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.trailing.equalTo(self)
    }
    
    iconImageView.snp.makeConstraints {
      $0.top.equalTo(self).offset(5)
      $0.leading.equalTo(self).offset(5)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    
    contentsTitle.snp.makeConstraints {
      $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
      $0.top.equalTo(self).offset(15)
    }
    
    progressView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(self).offset(10)
      $0.width.equalTo(self).offset(-20)
      $0.height.equalTo(10)
    }
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
