//
//  LoginView.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

// Protocol LoginViewDelegate
protocol LoginViewDelegate: class {
  func handleTabSignUpButton()
  func handleTabSignInButton(userId: String, passwd: String)
}


class LoginView: UIView {

  // MARK: - Properties
  var delegate: LoginViewDelegate?

  let loginLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인"
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = .white
    return label
  }()
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.text = "계정이름"
    label.font = .systemFont(ofSize: Standard.textSize )
    label.textColor = Standard.textColor
    return label
  }()
  
  let idTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = CommonUI.edgeColor.cgColor
    return textfield
  }()
  
  let passwdLabel: UILabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let passwdTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = CommonUI.edgeColor.cgColor
    textfield.tintColor = .orange
    return textfield
  }()
  
  let rememberButton: UIButton = {
    let button = UIButton()
    
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: Standard.textSize,
      weight: .regular,
      scale: .medium
    )
    let rectangleImage = UIImage(systemName: "rectangle", withConfiguration: systemSymbolConf)
    
    let checkRectangleImage = UIImage(systemName: "checkmark.square", withConfiguration: systemSymbolConf)
    
    button.setImage(rectangleImage, for: .normal)
    button.setImage(checkRectangleImage, for: .selected)
    button.imageView?.tintColor = Standard.textColor
    return button
  }()
  
  let rememberLabel: UILabel = {
    let label = UILabel()
    label.text = "정보 기억하기"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let regionLabel: UILabel = {
    let label = UILabel()
    label.text = "지역"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    return label
  }()
  
  let selectRegionButton: UIButton = {
    let button = UIButton()
    button.setTitle("대한민국", for: .normal)
    button.setTitleColor(Standard.textColor, for: .normal)
    button.imageView?.tintColor = .white
    return button
  }()
  
  let selectResionImageView: UIImageView = {
    let systemSymbolConf = UIImage.SymbolConfiguration(
      pointSize: Standard.textSize,
      weight: .regular,
      scale: .medium
    )
    guard let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: systemSymbolConf) else { return UIImageView() }
  
    let imageView = UIImageView(image: image)
    imageView.tintColor = Standard.textColor
    return imageView
  }()
  
  lazy var signInButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그인", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25)
    button.backgroundColor = .darkGray
    
    button.setTitleColor(Standard.textColor, for: .normal)
    button.setTitleColor(.lightGray, for: .disabled)
    
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    
    button.addTarget(self, action: #selector(handleSingIn), for: .touchUpInside)
    
//    button.isEnabled = false
    return button
  }()
  
  let findIdButton: UIButton = {
    let button = UIButton()
    button.setTitle("계정이름 찾기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.setTitleColor(Standard.textColor, for: .normal)
    button.imageView?.tintColor = .white
    return button
  }()
  
  let findPasswdButton: UIButton = {
    let button = UIButton()
    button.setTitle("패스워드 찾기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.setTitleColor(Standard.textColor, for: .normal)
    button.imageView?.tintColor = .white
    return button
  }()
  
  lazy var signupButton: UIButton = {
    let button = UIButton()
    button.setTitle("계정을 생성하시겠습니까?", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.setTitleColor(Standard.textColor, for: .normal)
    button.imageView?.tintColor = .white
    button.addTarget(self, action: #selector(handleSingUp), for: .touchUpInside)
    return button
  }()
  
  let seperateLineView1: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.3279156089, green: 0.257776916, blue: 0.104581289, alpha: 1)
    view.alpha = 0.5
    return view
  }()
  
  let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "FastWalkers")
    return imageView
  }()
  
  let companyImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "CompanyLogo")
    return imageView
  }()
  
  let companyInfoLabel: UILabel = {
    let label = UILabel()
    label.text = " 고객센터 | 개인정보 처리방침 | 약관 \n @ 2020 Fast Games, Inc All right"
    label.font = .systemFont(ofSize: Standard.textSize)
    label.textColor = Standard.textColor
    label.numberOfLines = 2
    return label
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureAutoLatout()
    hideKeyboard()
  }
  
  func configureAutoLatout() {
    
    self.layoutMargins = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    let marginGuide = self.layoutMarginsGuide
    
    [idTextField, passwdTextField, signInButton, seperateLineView1].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    [loginLabel, idLabel, passwdLabel, rememberButton, regionLabel, selectRegionButton, findIdButton, findPasswdButton].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    [rememberLabel, selectResionImageView, signupButton, logoImageView, companyImageView, companyInfoLabel].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.padding),
      
      idLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: Standard.padding),
      
      idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor,constant: Standard.smallPadding),
      idTextField.heightAnchor.constraint(equalToConstant: 40),
      
      passwdLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: Standard.padding),
      
      passwdTextField.topAnchor.constraint(equalTo: passwdLabel.bottomAnchor,constant: Standard.smallPadding),
      passwdTextField.heightAnchor.constraint(equalToConstant: 40),
      
      rememberButton.topAnchor.constraint(equalTo: passwdTextField.bottomAnchor, constant: Standard.padding),
      
      rememberLabel.leadingAnchor.constraint(equalTo: rememberButton.trailingAnchor, constant: Standard.smallPadding),
      
      rememberLabel.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor),
      
      regionLabel.topAnchor.constraint(equalTo: rememberButton.bottomAnchor, constant: Standard.padding),
      
      selectRegionButton.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: Standard.smallPadding),
      
      selectResionImageView.leadingAnchor.constraint(equalTo: selectRegionButton.trailingAnchor,constant: Standard.smallPadding),
      selectResionImageView.centerYAnchor.constraint(equalTo: selectRegionButton.centerYAnchor),
      
      signInButton.topAnchor.constraint(equalTo: selectRegionButton.bottomAnchor, constant: Standard.padding),
      signInButton.heightAnchor.constraint(equalToConstant: Standard.buttonHeight),
      
      findIdButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: Standard.padding),
      
      signupButton.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
      signupButton.centerYAnchor.constraint(equalTo: findIdButton.centerYAnchor),
      
      findPasswdButton.topAnchor.constraint(equalTo: findIdButton.bottomAnchor),
      
      seperateLineView1.topAnchor.constraint(equalTo: findPasswdButton.bottomAnchor),
      seperateLineView1.heightAnchor.constraint(equalToConstant: 2),
      
      logoImageView.topAnchor.constraint(equalTo: seperateLineView1.bottomAnchor,constant: Standard.smallPadding),
      logoImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: Standard.buttonHeight),
      logoImageView.widthAnchor.constraint(equalToConstant: Standard.buttonHeight),
      
      companyImageView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Standard.smallPadding),
      companyImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
      companyImageView.heightAnchor.constraint(equalToConstant: Standard.buttonHeight),
      companyImageView.widthAnchor.constraint(equalToConstant: Standard.buttonHeight),
      
      companyInfoLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: Standard.smallPadding),
      companyInfoLabel.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor),
      
    ])
  }
  
  // MARK: - Handler
  
  @objc func handleSingUp() {
    
    delegate?.handleTabSignUpButton()
    
  }
  
  @objc func handleSingIn() {
    
    guard let email = idTextField.text else { return }
    guard let passwd = passwdTextField.text else { return }
    
    delegate?.handleTabSignInButton(userId: email, passwd: passwd)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
