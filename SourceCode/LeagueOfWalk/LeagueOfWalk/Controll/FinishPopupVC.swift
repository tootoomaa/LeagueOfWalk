//
//  FinishPopupVC.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class FinishPopupVC: UIViewController {
  
  private let popupView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.pointColor
    view.layer.cornerRadius = CommonUI.cornerRadius
    view.layer.borderWidth = CommonUI.borderWidth
    view.layer.borderColor = CommonUI.edgeColor.cgColor
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = CommonUI.backgroundColor.withAlphaComponent(0.5)
    setUI()
  }
  
  private func setUI() {
    view.addSubview(popupView)
    
    popupView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.width.equalTo()
      $0.height.equalTo(100)
    }
  }
}
