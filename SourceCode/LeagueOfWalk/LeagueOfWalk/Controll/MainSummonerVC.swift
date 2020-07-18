//
//  MainSummonerVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import HealthKit

class MainSummonerVC: UIViewController {
  
  let testData = ["Level"]
  let healthStore = HKHealthStore()
  
  let layout = UICollectionViewFlowLayout()
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.backgroundColor = CommonUI.backgroundColor
    collectionView.register(
      MainSummonerCollectionViewCell.self,
      forCellWithReuseIdentifier: MainSummonerCollectionViewCell.identifier
    )
    collectionView.register(
      MainHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: MainHeaderCollectionReusableView.identifier
    )
    collectionView.register(
      MainFooterCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: MainFooterCollectionReusableView.identifier
    )
    
    return collectionView
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 로그인 상태 확인
    checkIfUserIsLoggedIn()
    
    // 케릭터 선택 여부 확인
    checkIfUserSelectCharacter()
    
    fetchUserSignupDate()
    
    // HealthKit 인증
    authorizeHealthKit()
    
    setUI()
  }
  
  // MARK: - Layout
  
  private func setUI() {
    view.backgroundColor = CommonUI.backgroundColor
    
    navigationSettings()
    setCollectionView()
    collectionView.dataSource = self
    collectionView.delegate = self 
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.top.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setCollectionView() {
    layout.sectionInset = .init(top: 15, left: 0, bottom: 15, right: 0)
    layout.minimumLineSpacing = 15
    layout.itemSize = CGSize(width: view.frame.width - 30, height: 70)
    //    checkIfUserIsLoggedIn()
    
    view.backgroundColor = CommonUI.backgroundColor
    
    navigationSettings()
  }
  
  func checkIfUserIsLoggedIn() {
    DispatchQueue.main.async {
      if Auth.auth().currentUser == nil {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
      }
    }
  }
  
  func checkIfUserSelectCharacter() {
    DispatchQueue.main.async {
      if let uid = Auth.auth().currentUser?.uid {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
          
          guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
          
          let user = User.init(uid: uid, dictionary: dictionary)
          
          if user.selectCharactor == "" {
            let selectCharVC = SelectCharVC()
            selectCharVC.userData = user
            selectCharVC.modalPresentationStyle = .fullScreen
            self.present(selectCharVC, animated: true, completion: nil)
          }
        }
      }
    }
  }
  
  func fetchUserSignupDate() {
    if let uid = Auth.auth().currentUser?.uid {
      Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
        print(snapshot)
        
        guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
        
        let user = User.init(uid: uid, dictionary: dictionary)
        print(user)
      }
    }
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
    
    return testData.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainSummonerCollectionViewCell.identifier, for: indexPath) as! MainSummonerCollectionViewCell
    
    cell.item = testData[indexPath.item]
    cell.progressValue = 0.95
    
    return cell
  }
}

extension MainSummonerVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    print("kind", kind)
    switch kind {
      
    case UICollectionView.elementKindSectionHeader:
      let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: MainHeaderCollectionReusableView.identifier,
        for: indexPath
        ) as! MainHeaderCollectionReusableView
      
      return header
      
    case UICollectionView.elementKindSectionFooter:
      let footer = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionFooter,
        withReuseIdentifier: MainFooterCollectionReusableView.identifier,
        for: indexPath
        ) as! MainFooterCollectionReusableView
      
      return footer
      
    default:
      assert(false, "Unexpected element kind")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width: CGFloat = collectionView.frame.width
    let height: CGFloat = 300
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let width: CGFloat = collectionView.frame.width
    let height: CGFloat = 220
    
    return CGSize(width: width, height: height)
  }
}

// MARK: - Relate HealthKit

extension MainSummonerVC {
  // HelthKit 인증
  func authorizeHealthKit() {
    let read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    let share = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    healthStore.requestAuthorization(toShare: share, read: read) { (chk, error) in
      if chk {
        print("Permission granted")
        self.getTodayTotalStepCount()
      }
    }
  }
  
  // MARK: - Today Total Step Count
  
  func getTodayTotalStepCount() {
    // HKSampleType
    guard let smapleType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
    // 시작과 종료
    let startDate = Calendar.current.startOfDay(for: Date())
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
    dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    let krDate = dateFormatter.string(from: startDate)
    print("Date :", krDate)
    // NSPredicate
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
    var intervar = DateComponents()
    intervar.day = 1
    
    let query = HKStatisticsCollectionQuery(
      quantityType: smapleType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum,
      anchorDate: startDate,
      intervalComponents: intervar
    )
    query.initialResultsHandler = { (sample, result, error) in
      
      if let myResult = result {
        myResult.enumerateStatistics(from: startDate, to: Date()) { (statistics, value) in
          if let count = statistics.sumQuantity() {
            let val = count.doubleValue(for: HKUnit.count())
            print("오늘 총 걸음 : \(val)걸음")
            self.sendWalkData(walkValue: val)
          }
        }
      }
    }
    healthStore.execute(query)
  }
  
  func sendWalkData(walkValue val: Double) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let walkingStatus = val
    
    let value = [User.walkingStatus: walkingStatus] as [String: Any]
    
    Database.database().reference().child("users").child(uid).updateChildValues(value) { (error, databaseReferece) in
      if let error = error {
        print("error", error.localizedDescription)
        return
      } else {
        print("Success Saved Data")
      }
    }
  }
}
