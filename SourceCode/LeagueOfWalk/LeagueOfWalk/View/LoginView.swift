//
//  LoginView.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIView {

  // MARK: - Properties

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
  
  let passwdTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = UIColor.orange.cgColor
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
    
    button.isEnabled = false
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
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureAutoLatout()
    
  }
  
  func configureAutoLatout() {
    
    [idTextField, passwdTextField, signInButton, seperateLineView1].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    [loginLabel, idLabel, passwdLabel, rememberButton, regionLabel, selectRegionButton, findIdButton, findPasswdButton].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    [rememberLabel, selectResionImageView, signupButton].forEach{
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.padding),
      
      idLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: Standard.padding),
      
      idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor,constant: 5),
      idTextField.heightAnchor.constraint(equalToConstant: 40),
      
      passwdLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: Standard.padding),
      
      passwdTextField.topAnchor.constraint(equalTo: passwdLabel.bottomAnchor,constant: 5),
      passwdTextField.heightAnchor.constraint(equalToConstant: 40),
      
      rememberButton.topAnchor.constraint(equalTo: passwdTextField.bottomAnchor, constant: Standard.padding),
      
      rememberLabel.leadingAnchor.constraint(equalTo: rememberButton.trailingAnchor, constant: 5),
      
      rememberLabel.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor),
      
      regionLabel.topAnchor.constraint(equalTo: rememberButton.bottomAnchor, constant: Standard.padding),
      
      selectRegionButton.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 5),
      
      selectResionImageView.leadingAnchor.constraint(equalTo: selectRegionButton.trailingAnchor,constant: 5),
      selectResionImageView.centerYAnchor.constraint(equalTo: selectRegionButton.centerYAnchor),
      
      signInButton.topAnchor.constraint(equalTo: selectRegionButton.bottomAnchor, constant: Standard.padding),
      signInButton.heightAnchor.constraint(equalToConstant: 50),
      
      findIdButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: Standard.padding),
      
      signupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      signupButton.centerYAnchor.constraint(equalTo: findIdButton.centerYAnchor),
      
      findPasswdButton.topAnchor.constraint(equalTo: findIdButton.bottomAnchor),
      
      seperateLineView1.topAnchor.constraint(equalTo: findPasswdButton.bottomAnchor),
      seperateLineView1.heightAnchor.constraint(equalToConstant: 2)
      
    ])
  }
  
  // MARK: - Handler
  
  @objc func handleSingUp() {
    
    print("tabSingupButton")
    
  }
  
  @objc func handleSingIn() {
    
    print("tabSingInButton")
    
    guard let email = idTextField.text,
          let passwd = passwdTextField.text else { return }
    
    Auth.auth().signIn(withEmail: email, password: passwd) { (result, error) in
      
      //  error 처리
      if let error = error {
        print("Erro Accure",error.localizedDescription)
        return
      }
      
      print("Success Signup user Login")
      
      
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
