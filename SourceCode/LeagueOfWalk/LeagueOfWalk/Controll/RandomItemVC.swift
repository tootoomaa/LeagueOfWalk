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
  
  // original 아이템 리스트
  var itemDataList: [Item] = []
  
  // 검색어에 필터링 된 아이탬 리스트
  var fileredOn: Bool = false
  var fileteredItemData:[Item] = []
  
  // 사용자 소유 아이템
  var myItemCheck: Bool = true
  var userItemList: [Item] = []

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
    label.isHidden = true
    return label
  }()

  
  // MARK: - Tamp Properties
  
  let arrayCount:CGFloat = 4
  
  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 인터넷 상 아이탬 데이터 파싱
    configureJSONParsing()

    // 뽑기 횟수 초기 적재
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.fetchUserPopItemCount(uid: uid, completion: { (count) in
      self.itemPopCount = count
    })
    
    print(uid)
    print(itemPopCount)
    
    
    if myItemCheck {
      fetchUserItem()
    }
    
    navigationSettings()
    
    configureAutoLayout()
    
    configureCollectionView()
    
    configureItemPop()
   
  }
  
  // MARK: - fetch data
  
  func fetchUserItem() {
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("user-items").child(uid).observeSingleEvent(of: .value) { (snapshot) in
      
      guard let value = snapshot.value as? Dictionary<String, AnyObject> else { return }
      
      for index in value.keys {
        for item in self.itemDataList {
          if item.index == index {
            self.userItemList.append(item)
            self.collectionView.reloadData()
          }
        }
      }
    }
  }
  
  func configureJSONParsing() {
    
    let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.14.1/data/ko_KR/item.json")
    
    // 1. URL Session을 통해서 데이터를 가져온다
    let urlTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if let error = error {
        print("error", error.localizedDescription)
        return
      }
      
      guard let respons = response as? HTTPURLResponse,
        (200..<400).contains(respons.statusCode)
        else { return print("Respobse Error")}
      
      guard let data = data else { return print("Get data Error") }
      
      // 2. data를 분석한다
      if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        if let data = jsonObject["data"] as? [String: Any] {
          
          for item in data {
            if let itemDetailData = item.value as? [String: Any] {
              
              if let itemName = itemDetailData["name"] as? String,
                let itemInfo = itemDetailData["plaintext"] as? String {
                
                let imageUrl = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.14.1/img/item/" + "\(item.key).png")

                let value = [
                  Item.name: itemName,
                  Item.information: itemInfo,
                  Item.imageUrl: imageUrl!
                  ] as [String : AnyObject]
                
                let itemData = Item.init(forIndex: item.key, dictionary: value)
                
                self.itemDataList.append(itemData)
              }
            }
          }
        }
      }
    }
    urlTask.resume()
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
  
  @objc func handlerTabItemBox(_ sender: UIButton) {
    let random: CGFloat = CGFloat(drand48()) - 0.5
    
    // 아이템 뽑기 가능 빨간 점 숨김
    itemCountLabel.isHidden = true
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.fetchUserPopItemCount(uid: uid, completion: { (count) in
      self.itemPopCount = count
      
      if self.itemPopCount == 0 || self.itemPopCount < 0 {
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
        let originX = self.itemPopButton.center.x
        let originY = self.itemPopButton.center.y
        let gapX = (originX - self.view.center.x)/4
        let gapY = (originY - self.view.center.y)/4
        
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
                // 아이탬 뽑기 횟수 1 차감
                guard let uid = Auth.auth().currentUser?.uid else { return }
                USER_ITEMPOPCOUNT_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                  guard let count = snapshot.value as? Int else { return }
                  USER_ITEMPOPCOUNT_REF.updateChildValues([uid : count-1])
                }
              })
            }
          }
        })
      }
    })
  }
}

// MARK: - Navigation settings

extension RandomItemVC {
  func navigationSettings() {
    
    let naviTitle: String = myItemCheck ? "My Item List" : CommonUI.NavigationBarTitle.itemListVC.rawValue
    
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: naviTitle
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
    
    navigationItem.searchController = searchController

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

// MARK: - UICollectionViewDataSource

extension RandomItemVC: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if fileredOn {
      return fileteredItemData.count
    } else if myItemCheck {
      return userItemList.count
    }
    
    return itemDataList.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemListCell.identifier, for: indexPath) as? ItemListCell else { fatalError() }
    
    if fileredOn {
      cell.itemData = fileteredItemData[indexPath.item]
    } else if myItemCheck {
      cell.itemData = userItemList[indexPath.item]
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

