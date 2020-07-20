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
  var count = 0
  var ments: String? {
    didSet {
      openMent.text = ments
    }
  }
  
  var pet: String? {
    didSet {
      heroImageView.image = UIImage(named: pet ?? "default")
    }
  }
  
  var mentsHidden: Bool? {
    didSet {
      openMent.isHidden = mentsHidden ?? true
    }
  }
  
  private let heroImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Egg")
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private let openMent: UILabel = {
    let label = UILabel()
    label.text = "알을 눌러 확인해보세요 !"
    label.textColor = .white
    label.font = UIFont(
      name: CommonUI.CustonFonts.koFont.rawValue,
      size: CommonUI.FontSize.Large.rawValue
    )
    label.isHidden = true
    
    return label
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    
    return tableView
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
      $0.width.equalTo(self)
      $0.height.equalTo(self)
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
      count = 0
      heroImageView.contentMode = .scaleAspectFill
      heroImageView.clipsToBounds = true
      
      let popup = PopupView()
      popup.imageString = ["1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3", "4-1", "4-2", "4-3", "5-1", "5-2", "5-3", " 6-1", "6-2", "6-3"].randomElement()
      pet = popup.imageString
      superview?.addSubview(popup)
      
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
