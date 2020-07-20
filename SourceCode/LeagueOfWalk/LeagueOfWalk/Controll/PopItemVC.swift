//
//  PopItemView.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class PopItemVC: UIViewController {
  
  // MARK: - Properties
  var itemButton:UIButton?
  var originX:CGFloat?
  var originY:CGFloat?
  var itemData:Item? {
    didSet {
      guard let itemData = itemData else { return }
      itemImageView.image = UIImage(named: itemData.index)
      itemNameLabel.text = itemData.name
    }
  }
  

  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "New Item!"
    label.textAlignment = .center
    label.font = UIFont(name: CommonUI.CustonFonts.enFont.rawValue, size: CommonUI.FontSize.Large.rawValue)
    label.textColor = CommonUI.edgeColor
    label.backgroundColor = CommonUI.backgroundColor
    return label
  }()
  
  let itemImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "3075") //3384
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = CommonUI.pointColor
    return imageView
  }()
  
  let itemNameLabel: UILabel = {
    let label = UILabel()
    label.text = "삼위일체"
    label.font = .boldSystemFont(ofSize: 13)
    label.textAlignment = .center
    label.font = UIFont(name: CommonUI.CustonFonts.enFont.rawValue, size: CommonUI.FontSize.Large.rawValue)
    label.textColor = CommonUI.edgeColor
    label.sizeToFit()
    return label
  }()
  
  lazy var okButton: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.backgroundColor = .darkGray
    
    button.setTitleColor(Standard.textColor, for: .normal)
    button.setTitleColor(.lightGray, for: .disabled)
    
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.addTarget(self, action: #selector(handleokButton(_:)), for: .touchUpInside)
    return button
  }()
  
  let itemaBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.edgeColor
    return view
  }()
  
  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .clear
    
    configureAutoLayoyut()
  }
  
  private func configureAutoLayoyut() {
    
    view.layoutMargins = UIEdgeInsets.init(top: 230, left: 100, bottom: 230, right: 100)
    let marginGuide = view.layoutMarginsGuide
    
    [itemaBackgroundView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    [titleLabel, itemImageView, itemNameLabel, okButton].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      
      itemaBackgroundView.topAnchor.constraint(equalTo: marginGuide.topAnchor,constant: -3),
      itemaBackgroundView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: -3),
      itemaBackgroundView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 3),
      itemaBackgroundView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 3),
      
      titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 50),
      
      itemImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      
      itemNameLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
      itemNameLabel.heightAnchor.constraint(equalTo: itemImageView.heightAnchor, multiplier: 0.2),
      
      okButton.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
      okButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
      okButton.heightAnchor.constraint(equalTo: itemNameLabel.heightAnchor, multiplier: 1),
      
    ])
    
  }
  
  // MARK: - handler
  
  @objc func handleokButton(_ sender: UIButton) {
    
    guard let itemButton = self.itemButton,
          let itemData = self.itemData,
           let originX = self.originX,
           let originY = self.originY else { return }
    
    guard let uid = Auth.auth().currentUser?.uid,
          let itemIndex = itemData.index else { return }
  
    
    // 뽑은 아이탬 DB 저장
    USER_ITEM_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
      
      guard let userItemList = snapshot.value as? [String: Int] else { return }
      
      if userItemList.keys.contains(itemData.index) {
        // 기존 보유 아이탬 수량 +1
        guard let itemCount = userItemList[itemData.index] else { return }
        USER_ITEM_REF.child(uid).updateChildValues([itemIndex:itemCount+1])
      } else {
        // 새로 뽑은 아이탬 수량 추가
        USER_ITEM_REF.child(uid).updateChildValues([itemIndex:1])
      }
    }
    
    // 화면이 사라지며 아이탬 버튼 에니메이션 추가
    dismiss(animated: true) {

      UIView.animate(withDuration: 1) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
            itemButton.center.y = originY + 150
            itemButton.center.x = originX
          }
          UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
            itemButton.center.y -= 150
            itemButton.alpha = 1
          }
        })
      }
    }
  }
}
