//
//  RandomItemVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class RandomItemVC: UIViewController {
  
  // MARK: - Properties
  var fileredOn: Bool = false
  var fileteredItemData:[String] = []
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  let searchController = UISearchController(searchResultsController: nil)
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Item List"
    label.font = UIFont(name: "FrizQuadrataBold", size: 25)
    label.textColor = CommonUI.edgeColor
    label.textAlignment = .center
    return label
  }()
  
  
  // MARK: - Tamp Properties
  let arrayCount:CGFloat = 3
  
  lazy var logoutButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    configureNavi()
    
    navigationSettings()
    
    configureAutoLayout()
    
    configureCollectionView()
    
    view.addSubview(logoutButton)
       
    logoutButton.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
  }

  private func configureNavi() {
    
    navigationItem.titleView = titleLabel

  }
  
  private func configureCollectionView() {
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(ItemListCell.self, forCellWithReuseIdentifier: ItemListCell.identifier)
    
  }
  
  private func configureAutoLayout() {
    
//    let safeGuide = view.safeAreaLayoutGuide
    view.layoutMargins = UIEdgeInsets.init(top: 0, left: Standard.padding, bottom: Standard.padding, right: Standard.padding)
    let marginGuide = view.layoutMarginsGuide
    [collectionView].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      
      collectionView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
    ])
    
  }
  
  // MARK: - Handle
  
  @objc func handleLogoutButton() {
    do {
      // attemp sign out
      try Auth.auth().signOut()
      
      //present login controller
      let loginVC = LoginVC()
      let navController = UINavigationController(rootViewController: loginVC)
      navController.modalPresentationStyle = .fullScreen
      self.present(navController, animated: true, completion: nil)
      print("SucessFull Log out User")
    } catch {
      //handle erorr
      print("Failed to sign out")
    }
  }
}

// MARK: - Navigation settings

extension RandomItemVC {
  func navigationSettings() {
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: CommonUI.NavigationBarTitle.itemListVC.rawValue
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
    
    navigationItem.searchController = searchController
    navigationItem.title = "Item List"

    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search..."
    searchController.searchBar.delegate = self

    definesPresentationContext = true
    
  }
}

// MARK: - UISearchBarDelegate
extension RandomItemVC: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    fileteredItemData = []
//    fileredOn = true
//
//    for cafe in cafeData where cafe.title.contains(searchText) {
//      for selectCafe in fileteredCafeData {
//        if selectCafe.title == cafe.title {
//          return
//        }
//      }
//      fileteredCafeData.append(cafe)
//    }
//    collectionView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    fileredOn = false
//    collectionView.reloadData()
  }
}

extension RandomItemVC: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCell.identifier, for: indexPath) as? ItemListCell else { fatalError() }
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RandomItemVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.padding
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Standard.padding/2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Standard.myEdgeInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (view.frame.size.width - view.layoutMargins.left - view.layoutMargins.right - Standard.padding/2*(arrayCount-1) -  Standard.smallPadding) / arrayCount
     // Standard.myEdgeInset.left - Standard.myEdgeInset.right
    return CGSize(width: width, height: width*1.3)
  }
}

