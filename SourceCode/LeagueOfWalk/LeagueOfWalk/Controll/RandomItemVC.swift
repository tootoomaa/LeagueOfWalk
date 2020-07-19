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
  var fileteredItemData:[Item] = []

  var itemDataList: [Item] = []
  var selectedItemList: [Item] = []
  
  var itemPopCount: Int = 0 {
    didSet {
      if itemPopCount == 0 {
        itemCountLabel.isHidden = true
      } else {
        itemCountLabel.isHidden = false
      }
    }
  }
  
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
  
  let itemPopButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "itembox"), for: .normal)
    button.backgroundColor = .clear
    return button
  }()

  let itemCountLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 8)
    label.backgroundColor = .red
    label.layer.cornerRadius = 7
    label.layer.masksToBounds = true
    return label
  }()

  
  // MARK: - Tamp Properties
  
  let arrayCount:CGFloat = 4
  
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
    itemPopCount = 3
    
    configureItemData()
    
    navigationSettings()
    
    configureAutoLayout()
    
    configureCollectionView()
    
    view.addSubview(logoutButton)
       
    logoutButton.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
    
    configureItemPop()
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.fetchUserData(uid: uid)
   
  }
  
  private func configureItemData() {
    
    let itemList: [String: String] = [ "1001": "속도의 장화",
                     "1004": "요정의 부석",
                     "1037": "곡괭이",
                     "1038": "BF 대검",
                     "3068": "태양 불꽃 망토",
                     "3074": "굶주린 히드라",
                     "3075": "가시 뼈"]
    
    let itemListKey = itemList.keys.sorted()
    
    for index in itemListKey {
      
      if let itemName = itemList[index] {
        let item = Item.init(forIndex: index, name: itemName)
        itemDataList.append(item)
      }
    }
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
  
  func configureItemPop() {
    
    itemPopButton.addTarget(self, action: #selector(handlerTabItemBox(_:)), for: .touchUpInside)
    
    let safeGuide = view.safeAreaLayoutGuide
    
    [itemPopButton, itemCountLabel].forEach{
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    [itemCountLabel].forEach{
      itemPopButton.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      itemPopButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Standard.padding),
      itemPopButton.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -Standard.padding),
      itemPopButton.widthAnchor.constraint(equalToConstant: 80),
      itemPopButton.heightAnchor.constraint(equalToConstant: 80),
      
      itemCountLabel.topAnchor.constraint(equalTo: itemPopButton.topAnchor, constant: -10),
      itemCountLabel.trailingAnchor.constraint(equalTo: itemPopButton.trailingAnchor, constant: +10),
      itemCountLabel.widthAnchor.constraint(equalToConstant: 15),
      itemCountLabel.heightAnchor.constraint(equalToConstant: 15)
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
  
  @objc func handlerTabItemBox(_ sender: UIButton) {
    let random: CGFloat = CGFloat(drand48()) - 0.5
    
    // 아이템 뽑기 가능 빨간 점 숨김
    itemCountLabel.isHidden = true
    
    if itemPopCount == 0 {
      // 아이탬을 뽑을 기회가 없는 경우 에니메이션
      UIView.animate(withDuration: 0.4) {
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
            self.itemPopButton.transform = self.itemPopButton.transform.rotated(by: random)
          })
          UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
            self.itemPopButton.transform = .identity
          })
          UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
            self.itemPopButton.transform = self.itemPopButton.transform.rotated(by: -random)
          })
          UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
            self.itemPopButton.transform = .identity
          })
        })
      }
    } else {
      // 아이탬 뽑기 에니메이션
      let originX = itemPopButton.center.x
      let originY = itemPopButton.center.y
      let gapX = (originX - view.center.x)/4
      let gapY = (originY - view.center.y)/4
      
      UIView.animate(withDuration: 1, animations:  {
        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
          UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
            self.itemPopButton.center.x -= gapX
            self.itemPopButton.center.y -= gapY
            self.itemPopButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
          })
          UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
            self.itemPopButton.center.x -= gapX
            self.itemPopButton.center.y -= gapY
            self.itemPopButton.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
          })
          UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
            self.itemPopButton.center.x -= gapX
            self.itemPopButton.center.y -= gapY
            self.itemPopButton.transform = CGAffineTransform(scaleX: 1.9, y: 1.9)
          })
          UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
            self.itemPopButton.center.x -= gapX
            self.itemPopButton.center.y -= gapY
            self.itemPopButton.transform = CGAffineTransform(scaleX: 2.1, y: 2.1)
          })
          UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1, animations: {
            self.itemPopButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.itemPopButton.alpha = 0
          })
        }) { finish in
          if finish {
            
            let popItemVC = PopItemVC()
            popItemVC.itemButton = self.itemPopButton
            popItemVC.originX = originX
            popItemVC.originY = originY
            popItemVC.itemData = self.itemDataList.randomElement()
            popItemVC.modalPresentationStyle = .overFullScreen
            self.present(popItemVC, animated: true, completion: {
              self.itemPopCount -= 1
            })
          }
        }
      })
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
    fileteredItemData = []
    fileredOn = true

    for item in itemDataList where item.name.contains(searchText) {
      for selectItem in fileteredItemData {
        if selectItem.name == item.name {
          return
        }
      }
      fileteredItemData.append(item)
    }
    
    collectionView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    fileredOn = false
    collectionView.reloadData()
  }
}

extension RandomItemVC: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if fileredOn {
      return fileteredItemData.count
    }
    
    return itemDataList.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCell.identifier, for: indexPath) as? ItemListCell else { fatalError() }
    
    if fileredOn {
      cell.itemData = fileteredItemData[indexPath.item]
      
    } else {
      cell.itemData = itemDataList[indexPath.item]
      
    }
    
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

