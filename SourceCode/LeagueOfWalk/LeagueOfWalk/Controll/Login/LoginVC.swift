//
//  LoginVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = #colorLiteral(red: 0.0005824246909, green: 0.04392331094, blue: 0.07332479209, alpha: 1)
    myView.backgroundColor = #colorLiteral(red: 0.0005824246909, green: 0.04392331094, blue: 0.07332479209, alpha: 1)
    myView.layoutMargins = UIEdgeInsets.init(top: 0, left: 50, bottom: 0, right: 50)
    
    let safeGuide = view.safeAreaLayoutGuide
    let margeGuide = view.layoutMarginsGuide
    [mainLogoImageView, myView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: margeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: margeGuide.trailingAnchor).isActive = true
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
      myView.heightAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 1.3),
      
    ])

  }
}
