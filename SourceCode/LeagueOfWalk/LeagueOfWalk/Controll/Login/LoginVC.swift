//
//  LoginVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
  
  // MARK: - Properties
  
  let mainLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Logo")
    return imageView
  }()
  
  let seperateLineView1: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.3279156089, green: 0.257776916, blue: 0.104581289, alpha: 1)
    return view
  }()
  
  let seperateLineView2: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.3279156089, green: 0.257776916, blue: 0.104581289, alpha: 1)
//    view.alpha = 0.1
    return view
  }()
  
  let myView = LoginView()
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = CommonUI.pointColor
    myView.backgroundColor = CommonUI.backgroundColor
    myView.delegate = self
    
    configureAutoLayout()
  }
  
  func configureAutoLayout() {
    
    let safeGuide = view.safeAreaLayoutGuide
    [mainLogoImageView, myView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    [seperateLineView1, seperateLineView2].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      mainLogoImageView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
      mainLogoImageView.heightAnchor.constraint(equalToConstant: 140),
      
      seperateLineView1.topAnchor.constraint(equalTo: mainLogoImageView.bottomAnchor),
      seperateLineView1.heightAnchor.constraint(equalToConstant: 2),
      
      myView.topAnchor.constraint(equalTo: seperateLineView1.bottomAnchor),
      myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

extension LoginVC: LoginViewDelegate {
  func handleTabSignInButton(userId: String, passwd: String) {
    print("tab SignIn handler in loginVC")
    
    Auth.auth().signIn(withEmail: userId, password: passwd) { (result, error) in
      
      //  error 처리
      if let error = error {
        print("Erro Accure",error.localizedDescription)
        return
      }
      
      print("Success Signup user Login")
      
    }
  }

  func handleTabSignUpButton() {
    
    let signUpVC = SignupVC()
    signUpVC.modalPresentationStyle = .fullScreen
    present(signUpVC, animated: true, completion: nil)
    
  }
}
