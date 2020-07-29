//
//  SingupVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {
  
  // MARK: - Properties
  
  let mainLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Logo")
    imageView.backgroundColor = CommonUI.pointColor
    return imageView
  }()
  
  let seperateLineView1: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.edgeColor
    return view
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
    textfield.layer.borderColor = CommonUI.edgeColor.cgColor
    return textfield
  }()
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.text = "이메일"
    label.font = .systemFont(ofSize: Standard.textSize )
    label.textColor = Standard.textColor
    return label
  }()
  
  let idTextField: UITextField = {
    let textfield = UITextField()
    textfield.backgroundColor = .darkGray
    textfield.layer.borderWidth = 1
    textfield.layer.borderColor = CommonUI.edgeColor.cgColor
    textfield.keyboardType = .emailAddress
    return textfield
  }()
  
  lazy var passwdLabel: UILabel = {
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
    textfield.isSecureTextEntry = true
    return textfield
  }()
  
  lazy var signUpButton: UIButton = {
    let button = UIButton()
    button.setTitle("회원가입", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25)
    button.backgroundColor = .darkGray
    
    button.setTitleColor(Standard.textColor, for: .normal)
    button.setTitleColor(.lightGray, for: .disabled)
    
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    
    button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
    return button
  }()
  
  lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25)
    button.backgroundColor = .darkGray
    
    button.setTitleColor(Standard.textColor, for: .normal)
    button.setTitleColor(.lightGray, for: .disabled)
    
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    
    button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = CommonUI.backgroundColor
  
    configureAutolayout()
    
    hideKeyboard()
        
  }
  
  func configureAutolayout() {
    
    let safeGuide = view.safeAreaLayoutGuide
    let marginGuide = view.layoutMarginsGuide
    view.layoutMargins = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    
    [mainLogoImageView, seperateLineView1].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    [nickNameTextField, idTextField, passwdTextField, signUpButton, cancelButton].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }

    [singUpLabel,nickNameLabel, idLabel, passwdLabel].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }

    NSLayoutConstraint.activate([
      mainLogoImageView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
      mainLogoImageView.heightAnchor.constraint(equalToConstant: 140),
      
      seperateLineView1.topAnchor.constraint(equalTo: mainLogoImageView.bottomAnchor),
      seperateLineView1.heightAnchor.constraint(equalToConstant: 2),
      
      singUpLabel.topAnchor.constraint(equalTo: seperateLineView1.bottomAnchor, constant: Standard.padding),
      
      nickNameLabel.topAnchor.constraint(equalTo: singUpLabel.bottomAnchor, constant: Standard.padding),
      
      nickNameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: Standard.smallPadding),
      nickNameTextField.heightAnchor.constraint(equalToConstant: 40),
      
      idLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: Standard.padding),
      
      idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor,constant: Standard.smallPadding),
      idTextField.heightAnchor.constraint(equalToConstant: 40),
      
      passwdLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: Standard.padding),
      
      passwdTextField.topAnchor.constraint(equalTo: passwdLabel.bottomAnchor, constant: Standard.smallPadding),
      passwdTextField.heightAnchor.constraint(equalToConstant: 40),
      
      signUpButton.topAnchor.constraint(equalTo: passwdTextField.bottomAnchor, constant: Standard.padding*2),
      signUpButton.heightAnchor.constraint(equalToConstant: Standard.buttonHeight),
      
      cancelButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Standard.padding),
      cancelButton.heightAnchor.constraint(equalToConstant: Standard.buttonHeight)
    ])
  }

  
  // MARK: - Handler
  
  @objc func handleCancelButton() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleSignUpButton() {
    guard let nickname = nickNameTextField.text else { return }
    guard let userId = idTextField.text else { return }
    guard let passwd = passwdTextField.text else { return }
    
    Auth.auth().createUser(withEmail: userId, password: passwd) { (result, error) in
      if let error = error {
        print("error:",error.localizedDescription)
        return
      }
      
      guard let uid = result?.user.uid else { return }
      
      let dictionary = [User.nickName: nickname,
                        User.selectCharctor: "",
                        User.walkingStatus: 0] as [String : Any]
      
      let value = [uid: dictionary]
      
      self.dismiss(animated: true, completion: {
        Database.database().reference().child("users").updateChildValues(value, withCompletionBlock:{ (error, ref) in
          
        })
      })
      
    }
    
  }
}
