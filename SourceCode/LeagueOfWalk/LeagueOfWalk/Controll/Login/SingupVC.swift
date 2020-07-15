//
//  SingupVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SingupVC: UIViewController {
  
  let mainLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Logo")
    return imageView
  }()
  
  let singUpLabel: UILabel = {
    let label = UILabel()
    label.text = "회원가입"
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = .white
    return label
  }()
  
  let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "소환사 이름"
    label.font = .systemFont(ofSize: Standard.textSize )
    label.textColor = Standard.textColor
    return label
  }()
  
  let nickNameTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = UIColor.orange.cgColor
    return textfield
  }()
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인 아이디"
    label.font = .systemFont(ofSize: Standard.textSize )
    label.textColor = Standard.textColor
    return label
  }()
  
  let idTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = UIColor.orange.cgColor
    return textfield
  }()
  
  let passwdLabel: UILabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    [mainLogoImageView].forEach{
      view.addSubview($0)
    }
    
  }
}
