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
  var temp = 0
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
    
    // HealthKit 인증
    authorizeHealthKit()
    
    fetchUserWalkData()
    
    setUI()
  }
  
  
  func popItemCountPlus() {
     
     guard let uid = Auth.auth().currentUser?.uid else { return }
     
     USER_ITEMPOPCOUNT_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
       guard let count = snapshot.value as? Int else { return }
       USER_ITEMPOPCOUNT_REF.updateChildValues([uid : count+1])
      print(" itemCount ++ \(uid), \(count+1)")
     }
   }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.collectionView.reloadData()
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
    cell.progressValue = CGFloat(temp / 1000)
    
    if (UserDefaults.standard.double(forKey: "walkingStatus") >= 1000) {
      UserDefaults.standard.set(true, forKey: "fullProgress")
      
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

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
      if (UserDefaults.standard.double(forKey: "walkingStatus") >= 1000) {
        header.mentsHidden = false
        header.pet = UserDefaults.standard.string(forKey: "petImage")
      }
      
      if let eggImage = UserDefaults.standard.string(forKey: "petImage") {
        header.pet = eggImage
      } else {
        header.pet = "Egg"
      }
      
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

// MARK: - HealthKit

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
    let date = NSDate(timeIntervalSince1970: (UserDefaults.standard.double(forKey: "signupDate"))) as Date
    
    let startDate = Calendar.current.startOfDay(for: date)
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
            print("하루당 걸음 횟수 : \(val)걸음")
            self.temp = Int(val)
          }
        }
      }
      self.sendWalkData(walkValue: Double(self.temp))
      print("총 걸음 : ", self.temp)
    }
    healthStore.execute(query)
  }
  
  // MARK: - Firebase
  
  func sendWalkData(walkValue val: Double) {
    let ref = Database.database().reference()
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let walkingStatus = val
    
    let value = [User.walkingStatus: walkingStatus] as [String: Any]
    
    ref.child("users").child(uid).updateChildValues(value) { (error, databaseReferece) in
      if let error = error {
        print("error", error.localizedDescription)
        return
      } else {
        print("Success Saved Data")
      }
    }
  }
  
  func fetchUserWalkData() {
    if let uid = Auth.auth().currentUser?.uid {
      let ref = Database.database().reference()
      ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
        print(snapshot)
        
        guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
        
        let user = User.init(uid: snapshot.key, dictionary: dictionary)
        
        UserDefaults.standard.set(user.walkingStatus ?? 0, forKey: "walkingStatus")
        UserDefaults.standard.set(user.signupDate, forKey: "signupDate")
      }
    }
  }  
}
