//
//  SelectCharactorVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectCharVC: UIViewController {
  
  // MARK: - Properties
  
  let centerCharView = SelectCharView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  // MARK: - TempProperties
  
  let charArray = ["Garen", "CardMaster", "WarWork", "Esrial", "Jarban", "Random"]
  
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
    let safeGuide = view.safeAreaLayoutGuide
    [centerCharView, collectionView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      centerCharView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
      centerCharView.heightAnchor.constraint(equalTo: centerCharView.widthAnchor),
      
      collectionView.topAnchor.constraint(equalTo: centerCharView.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
      
    ])
  }
}


extension SelectCharVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return charArray.count
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
    
    let width = (collectionView.frame.size.width - Standard.myEdgeInset.right - Standard.myEdgeInset.left - 10*(3-1))/3
    let height = (collectionView.frame.size.height - Standard.myEdgeInset.top - Standard.myEdgeInset.bottom - 10)/2
    return CGSize(width: width, height: height)
  }
}

// MARK: - UICollectionViewDelegate
extension SelectCharVC: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCharCell else { return }
    
    cell.layer.borderWidth = 4
    centerCharView.charName = cell.charName
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCharCell else { return }
       
       cell.layer.borderWidth = 0
//       cell.layer.borderColor = CommonUI.edgeColor.cgColor
  }
  
}
