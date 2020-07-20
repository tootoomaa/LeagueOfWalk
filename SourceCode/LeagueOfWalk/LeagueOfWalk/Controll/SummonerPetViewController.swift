//
//  SummonerPetViewController.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class SummonerPetViewController: UIViewController {
  
  var count = 0
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "Egg")
    iv.contentMode = .scaleToFill
    
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = CommonUI.backgroundColor.withAlphaComponent(0.6)
    
    setUI()
  }
  
  private func setUI() {
    view.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.centerX.centerY.equalTo(view)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if UserDefaults.standard.bool(forKey: "fullProgress") {
      // progress 100%
      switch count {
      case 0...3:
        didTabEggRotatedAnimation()
//        ments = "방금 알이 움직인건가요?"
      case 4...12:
        didTabEggRotatedAnimation()
//        ments = "무엇인가 안에서 움직이고 있네요 !!"
      case 12...19:
        didTabEggRotatedAnimation()
        didTabEggShakeAnimation()
//        ments = "움직임이 커졌네요 !!"
      case 19...26:
        didTabEggRotatedAnimation()
        didTabEggShakeAnimation()
//        ments = "곧 무엇인가 밖으로 나올것 같아요 !!"
      default:
        count = 0
        
        let petImage = ["1-1", "1-2", "1-3", "2-1", "2-2", "2-3", "3-1", "3-2", "3-3", "4-1", "4-2", "4-3", "5-1", "5-2", "5-3", " 6-1", "6-2", "6-3"].randomElement()
        UserDefaults.standard.set(petImage, forKey: "petImage")
        dismiss(animated: false, completion: nil)
        
      }
      count += 1
      print(count)
    }
  }
  
  private func didTabEggRotatedAnimation() {
    let random: CGFloat = CGFloat(drand48()) - 0.5
    
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.imageView.transform = self.imageView.transform.rotated(by: random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.imageView.transform = .identity
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.imageView.transform = self.imageView.transform.rotated(by: -random)
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.imageView.transform = .identity
      })
    })
  }
  
  private func didTabEggShakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.imageView.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        //        self.heroImageView.transform = .identity
        self.imageView.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.imageView.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.imageView.transform = .identity
        self.imageView.center.x += 8
      })
    })
  }
  
}
