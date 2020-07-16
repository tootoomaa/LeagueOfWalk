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
  
  var count = 0
  var ments: String? {
    didSet {
      openMent.text = ments
    }
  }
  
  var isHoldingImage = false
  static let identifier = "MainHeaderCollectionReusableView"
  private let heroImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Egg")
    
    return imageView
  }()
  
  private let openMent: UILabel = {
    let label = UILabel()
    label.text = "알을 눌러 확인하세요"
    label.textColor = .white
    label.font = UIFont(
      name: CommonUI.CustonFonts.koFont.rawValue,
      size: CommonUI.FontSize.Large.rawValue
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
    
    [heroImageView, openMent].forEach {
      self.addSubview($0)
    }
    heroImageView.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
    openMent.snp.makeConstraints {
      $0.bottom.equalTo(heroImageView)
      $0.centerX.equalTo(heroImageView)
    }
  }
  
  // MARK: - Action
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    switch count {
    case 0...3:
      didTabEggRotatedAnimation()
      ments = "방금 알이 움직인건가요?"
    case 4...12:
      didTabEggRotatedAnimation()
      ments = "무엇인가 안에서 움직이고 있네요 !!"
    case 12...19:
      didTabEggRotatedAnimation()
      didTabEggShakeAnimation()
      ments = "움직임이 커졌네요 !!"
    case 19...26:
      didTabEggRotatedAnimation()
      didTabEggShakeAnimation()
      ments = "곧 무엇인가 밖으로 나올것 같아요 !!"
    default:
      print("Open")
      ments = "당신의 전설이가 알을깨고 나왔습니다 !!"
      count = 0
    }
    
    count += 1
    print(count)
    
  }
  
  private func didTabEggRotatedAnimation() {
    let random: CGFloat = CGFloat(drand48()) - 0.5
    
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = self.heroImageView.transform.rotated(by: random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.heroImageView.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.heroImageView.transform = self.heroImageView.transform.rotated(by: -random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = .identity
      })
    })
  }
  
  private func didTabEggShakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.heroImageView.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
//        self.heroImageView.transform = .identity
        self.heroImageView.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.heroImageView.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.heroImageView.transform = .identity
        self.heroImageView.center.x += 8
      })
    })
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
