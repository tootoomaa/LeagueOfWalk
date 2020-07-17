//
//  MainSummonerTableViewCell.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/17.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainSummonerTableViewCell: UITableViewCell {
  
  static let identifier = "MainSummonerTableViewCell"
  
  var row: String? {
    didSet {
      contentsTitle.text = row
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
      size: CommonUI.FontSize.small.rawValue
    )
    
    return label
  }()
  
  lazy var progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    view.progress = 0.5
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = CommonUI.pointColor
    self.layer.cornerRadius = CommonUI.cornerRadius
    self.layer.borderWidth = CommonUI.borderWidth
    self.layer.borderColor = CommonUI.edgeColor.cgColor
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    [contentsTitle, progressView].forEach {
      self.addSubview($0)
    }
    
    contentsTitle.snp.makeConstraints {
      $0.top.equalTo(self).offset(10)
      $0.leading.equalTo(self).offset(20)
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


