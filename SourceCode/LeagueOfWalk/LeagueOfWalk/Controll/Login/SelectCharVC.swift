//
//  SelectCharactorVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class SelectCharVC: UIViewController {
  
  // MARK: - Properties
  
  var userData: User?
  
  let centerCharView = SelectCharView()
  
  var selectCharName: String = "Garen"
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  lazy var selectButton: UIButton = {
    let button = UIButton()
    button.setTitle("선택", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 25)
    button.backgroundColor = .darkGray
    
    button.setTitleColor(Standard.textColor, for: .normal)
    button.setTitleColor(.lightGray, for: .disabled)
    
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    
    button.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
    
    //    button.isEnabled = false
    return button
  }()
  
  // MARK: - TempProperties
  
  let charArray = ["Garen", "C-Master", "WarWork", "Esrial", "Jarban", "Random"]
  
  // MARK: - Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureSetUI()
    
    configureLayout()
    
  }
  
  func configureSetUI() {
    view.backgroundColor = CommonUI.pointColor
    
    centerCharView.layer.borderColor = CommonUI.edgeColor.cgColor
    centerCharView.layer.borderWidth = 1
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = CommonUI.pointColor
    collectionView.register(SelectCharCell.self, forCellWithReuseIdentifier: SelectCharCell.identifier)
    
    //    collectionView.layer.borderColor = CommonUI.edgeColor.cgColor
    //    collectionView.layer.borderWidth = 2
  }
  
  func configureLayout() {
    view.layoutMargins = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
    
    let marginGuide = view.layoutMarginsGuide
    let safeGuide = view.safeAreaLayoutGuide
    [centerCharView, collectionView, selectButton].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      centerCharView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
      centerCharView.heightAnchor.constraint(equalTo: centerCharView.widthAnchor, multiplier: 0.8),
      
      collectionView.topAnchor.constraint(equalTo: centerCharView.bottomAnchor),
      
      selectButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Standard.smallPadding),
      selectButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor),
      
    ])
  }
  
  // MARK: - Handler
  
  @objc func handleSelectButton() {
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let userData = userData else { return }
    guard let nickName = userData.nickName else { return }
    
    let value = [User.nickName: nickName,
                 User.selectCharctor: selectCharName,
                 User.warkingStatus: userData.warkingStatus] as [String : Any]
    
    Database.database().reference().child("users").child(uid).updateChildValues(value) { (error, databaseReferece) in
      if let error = error {
        print("error", error.localizedDescription)
        return
      } else {
        print("Success Saved Data")
      }
      
      self.view.window?.rootViewController?.dismiss(animated: true)
    }
  }
  
}

// MARK: - UICollectionViewDataSource
extension SelectCharVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return characterDic.keys.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCharCell.identifier, for: indexPath) as? SelectCharCell else { fatalError() }
    
    cell.layer.borderColor = CommonUI.edgeColor.cgColor
    cell.charName = charArray[indexPath.item]
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SelectCharVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.myEdgeInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (collectionView.frame.size.width - Standard.myEdgeInset.right - Standard.myEdgeInset.left - 20 - 10*(3-1))/3
    let height = (collectionView.frame.size.height - Standard.myEdgeInset.top - Standard.myEdgeInset.bottom - 10)/2
    return CGSize(width: width, height: height)
  }
}

// MARK: - UICollectionViewDelegate
extension SelectCharVC: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCharCell else { return }
    guard let charName = cell.charName else { return }
    
    cell.layer.borderWidth = 4
    centerCharView.charName = cell.charName
    selectCharName = charName
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCharCell else { return }
    
    cell.layer.borderWidth = 0
  }
}


