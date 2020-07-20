//
//  UserRankingVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Firebase

class UserRankingVC: UIViewController {
    
  
    // MARK: - Properties
    var userRankLocationInArray: Int = 0
    var setUserRankLocation: Bool = false
  
    var userDatas: [User] = [] {
      didSet {
        // 사용자 순위 Cell 커스터 마이즈를 위한 등수 저장
        guard let uid = Auth.auth().currentUser?.uid else { fatalError() }
        for index in 0..<userDatas.count {
          if userDatas[index].uid == uid {
            userRankLocationInArray = index
          }
        }
      }
    }
  
    enum tier: String {
      case first = "platinum_5"
      case second = "diamond_5"
      case third = "gold_5"
      case etc = "bronze_5"
    }
  
    let backgroundView = UIImageView()
    let titleLabel =  UILabel()
    
    let rank1stView = UserRankingView()
    let rank2stView = UserRankingView()
    let rank3stView = UserRankingView()
    
    
    let rankingTable = UITableView()
    let tableBorder = CALayer()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchAllUserData()
      
        setView()
      
        setTable()
    }  
  
  private func fetchAllUserData() {
    Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
      
      guard let allUserData = snapshot.value as? Dictionary<String, AnyObject> else { return }
      
      for sigleUserData in allUserData {
        guard let userDetailData = sigleUserData.value as? Dictionary<String, AnyObject> else { return }
        let userData = User.init(uid: sigleUserData.key, dictionary: userDetailData)
        // 사용자 데이터 추가
        self.userDatas.append(userData)
        
        // 내림차순 정렬
        self.userDatas.sort { (user1, user2) -> Bool in
          user1.warkingStatus > user2.warkingStatus
        }
        
        self.rankingTable.reloadData()
      }
    })
  }
    
    // MARK: - Layout Subview
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableBorder.backgroundColor = UIColor.systemYellow.cgColor
        tableBorder.frame = CGRect(x:0,
                                   y: view.frame.height - rankingTable.frame.height - view.safeAreaInsets.bottom,
                                   width: rankingTable.frame.width,
                                   height: 0.5)
        
        view.layer.addSublayer(tableBorder)
    }
    
    // MARK: - Set Ranking View
    
    func setView(){
        
        navigationItem.titleView = NavigationBarView(
            frame: .zero,
            title: CommonUI.NavigationBarTitle.rankingVC.rawValue
        )
        
        let naviBar = self.navigationController?.navigationBar
        naviBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar?.shadowImage = UIImage()
        naviBar?.isTranslucent = true
        naviBar?.backgroundColor = UIColor.clear
        
        backgroundView.image = UIImage(named: "RankingBack")
        view.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        rank1stView.rankLabel.text = "1 위"
        rank1stView.tierImage.image = UIImage(named: tier.first.rawValue)
        view.addSubview(rank1stView)
        
        rank1stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank1stView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rank1stView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rank1stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            rank1stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.38)
        ])
        
        rank2stView.rankLabel.text = "2 위"
        rank2stView.tierImage.image = UIImage(named: tier.second.rawValue)
        view.addSubview(rank2stView)
        
        rank2stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank2stView.topAnchor.constraint(equalTo: rank1stView.bottomAnchor, constant: 40),
            rank2stView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                  constant: -(view.frame.width/2 - (view.frame.width * 0.31))/2),
            rank2stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            rank2stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.33)
        ])
        
        rank3stView.rankLabel.text = "3 위"
        rank3stView.tierImage.image = UIImage(named: tier.third.rawValue)
        view.addSubview(rank3stView)

        rank3stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank3stView.topAnchor.constraint(equalTo: rank1stView.bottomAnchor, constant: 40),
            rank3stView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                  constant: (view.frame.width/2 - (view.frame.width * 0.31))/2),
            rank3stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            rank3stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.33)
        ])
    }
    
    // MARK: - Set Table
    
    func setTable(){
        rankingTable.rowHeight = 45
        rankingTable.allowsSelection = false
        rankingTable.separatorColor = .systemYellow
        rankingTable.backgroundColor = .clear
        rankingTable.dataSource = self
        rankingTable.delegate = self
        rankingTable.register(UserRankingCustomCell.self, forCellReuseIdentifier: UserRankingCustomCell.identifier)
        view.addSubview(rankingTable)
        
        rankingTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankingTable.topAnchor.constraint(equalTo: rank3stView.bottomAnchor, constant: 40),
            rankingTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rankingTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rankingTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView Data

extension UserRankingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return userDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserRankingCustomCell.identifier,
                                                 for: indexPath) as! UserRankingCustomCell
        cell.backgroundColor = .clear
      
        var imageString: String = ""
        switch indexPath.row {
        case 0:
          imageString = tier.first.rawValue
          rank1stView.userData = userDatas[indexPath.row]
        case 1:
          imageString = tier.second.rawValue
          rank2stView.userData = userDatas[indexPath.row]
        case 2:
          imageString = tier.third.rawValue
          rank3stView.userData = userDatas[indexPath.row]
        default:
          imageString = tier.etc.rawValue
        }
      
        if indexPath.row == userRankLocationInArray {
          cell.layer.borderWidth = 2
          cell.layer.borderColor = CommonUI.edgeColor.cgColor
        }
      
        cell.rankLabel.text = "\(indexPath.row + 1) 위"
        cell.nameLabel.text = userDatas[indexPath.row].nickName
        cell.scoreLabel.text = "scroe: \(userDatas[indexPath.row].warkingStatus)"
        cell.tierImage.image = UIImage(named: imageString)
        return cell
    }
}

extension UserRankingVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.row == userRankLocationInArray {
      cell.layer.borderWidth = 2
      cell.layer.borderColor = CommonUI.edgeColor.cgColor
    } else {
      cell.layer.borderColor = UIColor.clear.cgColor
    }
    
    // 최소 실행시 사용자의 랭킹 위치로 테이블 cell 이동
    if setUserRankLocation == false {
      if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
          if indexPath == lastVisibleIndexPath {
              rankingTable.scrollToRow(
                at: IndexPath.init(row: userRankLocationInArray, section: 0),
                at: .middle,
                animated: false
              )
            setUserRankLocation = true
          }
      }
    }
  }
}


