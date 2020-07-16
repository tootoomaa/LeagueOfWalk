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
      self.levelLabel.text = item
    }
  }
  
  var progressValue: CGFloat? {
    didSet {
      self.progressView.progress = progressValue ?? 0
    }
  }
  
  lazy var levelLabel: UILabel = {
    let label = UILabel()

    return label
  }()
  
  private let contentsTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(
      name: CommonUI.CustonFonts.enFontRagular.rawValue,
      size: CommonUI.FontSize.small.rawValue
    )
    
    label.text = "Level"
    
    return label
  }()
  
  private let walkProgressView: UIProgressView = {
    let progressView = UIProgressView(progressViewStyle: .bar)
    progressView.progress = .infinity
//    progressView.tintColor = .none
    progressView.layer.cornerRadius = CommonUI.cornerRadius
    
    return progressView
  }()
  
  lazy var progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    view.progress = 0.5
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = CommonUI.pointColor
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    walkProgressView.layer.addSublayer(layer)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
    [levelLabel, contentsTitle, progressView].forEach {
      self.addSubview($0)
    }

    levelLabel.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.trailing.equalTo(self)
    }
    
    contentsTitle.snp.makeConstraints {
      $0.top.equalTo(self).offset(20)
      $0.leading.equalTo(self).offset(20)
    }
    
    levelLabel.snp.makeConstraints {
      $0.leading.equalTo(contentsTitle.snp.trailing).offset(10)
      $0.top.equalTo(self).offset(15)
    }
    
    progressView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(self).offset(20)
      $0.width.equalTo(self).offset(-40)
      $0.height.equalTo(10)
    }
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
