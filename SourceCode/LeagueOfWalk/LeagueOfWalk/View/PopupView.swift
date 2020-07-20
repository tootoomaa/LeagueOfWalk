//
//  PopupView.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class PopupView: UIView {

  var imageString: String? {
    didSet {
      imageView.image = UIImage(named: imageString ?? "default")
      UserDefaults.standard.set(imageString, forKey: "petImage")
    }
  }
  
  private let popupView: UIView = {
    let v = UIView()
    v.backgroundColor = CommonUI.pointColor
    v.layer.cornerRadius = CommonUI.cornerRadius
    v.layer.borderWidth = CommonUI.borderWidth
    v.layer.borderColor = CommonUI.edgeColor.cgColor
    
    return v
  }()
  
  private let titleLabel: UILabel = {
    let l = UILabel()
    l.text = "당신의 전설이가\n알을깨고 나왔습니다 !!"
    l.font = UIFont(
      name: CommonUI.CustonFonts.koFont.rawValue,
      size: CommonUI.FontSize.Medium.rawValue
    )
    l.textColor = .white
    l.textAlignment = .center
    l.numberOfLines = 2
    
    return l
  }()
  
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "1-3")
    iv.contentMode = .scaleToFill
    iv.layer.borderWidth = CommonUI.borderWidth
    iv.layer.borderColor = CommonUI.edgeColor.cgColor
    
    return iv
  }()
  
  private let button: UIButton = {
    let b = UIButton()
    b.setTitle("확인", for: .normal)
    b.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    b.titleLabel?.textAlignment = .center
    
    return b
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = UIScreen.main.bounds
    self.backgroundColor = CommonUI.backgroundColor.withAlphaComponent(0.6)
    
    setUI()
  }
  
  private func setUI() {
    self.addSubview(popupView)
    
    popupView.snp.makeConstraints {
      $0.centerX.equalTo(self)
      $0.centerY.equalTo(self)
      $0.width.equalTo(self.frame.width / 1.25)
      $0.height.equalTo(self.frame.height / 2)
    }
    
    [titleLabel, imageView, button].forEach {
      popupView.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(popupView).offset(20)
      $0.trailing.leading.equalTo(popupView)
//      $0.height.equalTo(popupView.frame.height / 5)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(25)
      $0.width.equalToSuperview()
    }
    
    button.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom)
      $0.width.equalToSuperview()
      $0.height.equalTo(40)
      $0.bottom.equalToSuperview()
    }
    
  }
  
  @objc private func didTapButton() {
    self.removeFromSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
