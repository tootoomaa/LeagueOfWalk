//
//  MainViewController.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
  
  var progressValue: CGFloat? {
    didSet {
      self.progressView.progress = progressValue ?? 0
    }
  }
  
  private let heroImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "Egg")
    iv.contentMode = .scaleAspectFit
    
    return iv
  }()
  
  private let contentsView: UILabel = {
    let l = UILabel()
    l.backgroundColor = CommonUI.pointColor
    l.layer.cornerRadius = CommonUI.cornerRadius
    l.layer.borderWidth = CommonUI.borderWidth
    l.layer.borderColor = CommonUI.edgeColor.cgColor
    l.text = "teijakljsdfl"
    
    return l
  }()
  
  lazy var progressView: ProgressView = {
    let view = ProgressView()
    view.backgroundColor = .gray
    view.progress = 0

    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [heroImageView, progressView, contentsView])
    sv.axis = .vertical
    sv.spacing = 10
    
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  private func setUI() {
    view.backgroundColor = CommonUI.backgroundColor
    view.addSubview(stackView)
    
    navigationSettings()
    
    let guid = view.safeAreaLayoutGuide
    
    stackView.snp.makeConstraints {
      $0.top.bottom.equalTo(guid)
      $0.trailing.equalTo(guid).offset(-20)
      $0.leading.equalTo(guid).offset(20)
      $0.bottom.equalTo(guid).offset(-20)
    }
    
    // -
    
    heroImageView.snp.makeConstraints {
      $0.top.trailing.leading.equalToSuperview()
    }
    
    progressView.snp.makeConstraints {
      $0.top.equalTo(heroImageView.snp.bottom)
      $0.trailing.leading.equalToSuperview()
      $0.height.equalTo(10)
    }
    
    contentsView.snp.makeConstraints {
      $0.top.equalTo(progressView.snp.bottom).offset(10)
      $0.trailing.bottom.leading.equalToSuperview()
      $0.height.equalTo(view.frame.height / 4)
    }
  }
  // navigation
  func navigationSettings() {
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: CommonUI.NavigationBarTitle.mainSummonerVC.rawValue
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
  }
}
