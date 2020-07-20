//
//  UIViewControllerExtension.swift
//  LeagueOfWalk
//
//  Created by 요한 on 2020/07/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

// MARK: - Hide Keyboard

extension UIViewController {
  func hideKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
