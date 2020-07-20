//
//  SelectCharacterView.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectCharView: UIView {

  // MARK: - Properties
  
  var charName: String? {
    didSet {
      guard let charName = charName else { return }
      guard let charData = characterDic[charName] else { return }
      
      charNameLabel.text = charName
      charImageView.image = UIImage(named: charName)
      
      charInfoTextView.text = charData["charInfo"]
      charSkillName.text = charData["skillName"]
      charSkillEffect.text = charData["skillEffect"]
      
    }
  }
  
  let charImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Garen")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  var charNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Garen"
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = CommonUI.edgeColor
    label.textAlignment = .left
    return label
  }()
  
  let charInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "케릭터 설명"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let charInfoTextView: UITextView = {
    let textView = UITextView()
    textView.text = "이 영웅은 강력한 체력을 바탕으로 끝임 없이 걷습니다. 특유의 회전으로 더욱 빠르게 걷습니다."
    textView.backgroundColor = CommonUI.pointColor
    textView.font = .systemFont(ofSize: Standard.textSize)
//    textView.adjustsFontForContentSizeCategory = true
    textView.isEditable = false
    textView.isSelectable = false
    return textView
  }()
  
  let charSkillNameLabel: UILabel = {
    let label = UILabel()
    label.text = "스킬 이름"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let charSkillName: UILabel = {
    let label = UILabel()
    label.text = " 아주 아주 강력한 회전"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = .white
    return label
  }()
  
  let charSkillInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "스킬 설명"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let charSkillInfo: UITextView = {
    let textView = UITextView()
    textView.text = "이 영웅은 강한 회전을 이용하여 걷기 때문에 회전에 의한 관성으로 잠자면서도 걸을 수 있습니다."
    textView.font = .systemFont(ofSize: Standard.textSize)
    return textView
  }()
  
  let charSkillEffectLabel: UILabel = {
    let label = UILabel()
    label.text = "스킬 효과"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let charSkillEffect: UILabel = {
    let label = UILabel()
    label.text = " 일일 걸음 수 500 추가"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = .white
    return label
  }()
  
  
  
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = CommonUI.pointColor
    
    self.layoutMargins = UIEdgeInsets.init(top: 10, left: 10, bottom: 5, right: 10)
    let marginGuide = self.layoutMarginsGuide
    let viewWidth = UIScreen.main.bounds.width - self.layoutMargins.left - self.layoutMargins.right - Standard.padding
    
    [charImageView, charNameLabel].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.widthAnchor.constraint(equalToConstant: viewWidth/2).isActive = true
    }

    //charInfoLabel,
    [ charInfoTextView, charSkillInfo, charInfoLabel, charSkillNameLabel, charSkillName,charSkillEffectLabel, charSkillEffect].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: Standard.padding).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
      $0.widthAnchor.constraint(equalToConstant: viewWidth/2).isActive = true
    }

//    [].forEach{
//      self.addSubview($0)
//      $0.translatesAutoresizingMaskIntoConstraints = false
//    }

    NSLayoutConstraint.activate([
      
      charNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
      charNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
      
      charImageView.topAnchor.constraint(equalTo: charNameLabel.bottomAnchor,constant: Standard.smallPadding),
      charImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -Standard.padding),
      charImageView.heightAnchor.constraint(equalTo: charNameLabel.heightAnchor, multiplier: 5),

      charInfoLabel.topAnchor.constraint(equalTo: charNameLabel.bottomAnchor, constant: Standard.smallPadding),

      charInfoTextView.topAnchor.constraint(equalTo: charInfoLabel.bottomAnchor, constant: Standard.smallPadding),
//      charInfoTextView.heightAnchor.constraint(equalToConstant: 90),
      charInfoTextView.heightAnchor.constraint(equalTo: charInfoLabel.heightAnchor, multiplier: 5),

      charSkillNameLabel.topAnchor.constraint(equalTo: charInfoTextView.bottomAnchor, constant: Standard.smallPadding),

      charSkillName.topAnchor.constraint(equalTo: charSkillNameLabel.bottomAnchor, constant: Standard.smallPadding),

      charSkillEffectLabel.topAnchor.constraint(equalTo: charSkillName.bottomAnchor, constant: Standard.smallPadding),

      charSkillEffect.topAnchor.constraint(equalTo: charSkillEffectLabel.bottomAnchor, constant: Standard.smallPadding),
    ])
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
