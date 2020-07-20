//
//  MainSummonerCollectionViewCell.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class MainSummonerCollectionViewCell: UICollectionViewCell {
  
  let data = ["Level", "Today Walk"]
  
  static let identifier = "MainSummonerCollectionViewCell"
  var tableCellCount: Int? = 0
  
  var item: String? {
    didSet {
      contentsTitle.text = item
    }
  }
  
  var progressValue: CGFloat? {
    didSet {
        self.progressView.progress = progressValue ?? 0
    }
  }
  
  lazy var contentsTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(
      name: CommonUI.CustonFonts.enFontRagular.rawValue,
      size: CommonUI.FontSize.Medium.rawValue
    )
    
    return label
  }()
  
  lazy var progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    view.progress = 0
    
    return view
  }()
  
  private let zeroPercentLabe: UILabel = {
    let label = UILabel()
    label.text = "0%"
    label.textColor = .white
    label.font = UIFont(
      name: CommonUI.CustonFonts.koFontRegular.rawValue,
      size: CommonUI.FontSize.small.rawValue - 3
    )
    
    return label
  }()
  
  private let halfPercentLabel: UILabel = {
    let label = UILabel()
    label.text = "50%"
    label.textColor = .white
    label.font = UIFont(
      name: CommonUI.CustonFonts.koFontRegular.rawValue,
      size: CommonUI.FontSize.small.rawValue - 3
    )
    
    return label
  }()
  
  private let fullPercentLabel: UILabel = {
    let label = UILabel()
    label.text = "100%"
    label.textColor = .white
    label.font = UIFont(
      name: CommonUI.CustonFonts.koFontRegular.rawValue,
      size: CommonUI.FontSize.small.rawValue - 3
    )
    
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    self.backgroundColor = CommonUI.pointColor
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    [contentsTitle, progressView, zeroPercentLabe, halfPercentLabel, fullPercentLabel].forEach {
      self.addSubview($0)
    }
    
    contentsTitle.snp.makeConstraints {
      $0.top.equalTo(self).offset(10)
      $0.leading.equalTo(self).offset(20)
    }
    
    progressView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(self).offset(20)
      $0.trailing.equalTo(self).offset(-20)
      $0.height.equalTo(10)
    }
    
    zeroPercentLabe.snp.makeConstraints {
      $0.leading.equalTo(self).offset(20)
      $0.top.equalTo(progressView.snp.bottom).offset(5)
    }
    
    halfPercentLabel.snp.makeConstraints {
      $0.centerX.equalTo(self)
      $0.top.equalTo(progressView.snp.bottom).offset(5)
    }
    
    fullPercentLabel.snp.makeConstraints {
      $0.trailing.equalTo(self).offset(-20)
      $0.top.equalTo(progressView.snp.bottom).offset(5)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


