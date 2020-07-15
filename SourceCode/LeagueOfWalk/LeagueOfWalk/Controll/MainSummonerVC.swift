//
//  MainSummonerVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MainSummonerVC: UIViewController {
  
  let testData = ["1", "2"]
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.backgroundColor = CommonUI.backgroundColor
    collectionView.register(
      MainSummonerCollectionViewCell.self,
      forCellWithReuseIdentifier: MainSummonerCollectionViewCell.identifier
    )
    
    return collectionView
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    view.backgroundColor = CommonUI.backgroundColor
    navigationSettings()
    setCollectionView()
    collectionView.dataSource = self

    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setCollectionView() {
    layout.sectionInset = .init(top: 30, left: 0, bottom: 30, right: 0)
    layout.minimumLineSpacing = 30
    layout.itemSize = CGSize(width: view.frame.width - 60, height: 100)
  }
}

// MARK: - Navigation settings

extension MainSummonerVC {
  func navigationSettings() {
    navigationItem.titleView = NavigationBarView(
      frame: .zero,
      title: CommonUI.NavigationBarTitle.mainSummonerVC.rawValue
    )
    
    let navBar = self.navigationController?.navigationBar
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
  }
}

// MARK: - UICollectionViewDataSource

extension MainSummonerVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainSummonerCollectionViewCell.identifier, for: indexPath) as! MainSummonerCollectionViewCell
    
    cell.item = testData[indexPath.item]
    
    return cell
  }
}
