//
//  UserRankingVC.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserRankingVC: UIViewController {
    
    let backgroundView = UIImageView()
    
    let rank1stView = UserRankingView()
    let rank2stView = UserRankingView()
    let rank3stView = UserRankingView()
    
    
    let rankingTable = UITableView()
    let tableBorder = CALayer()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setTable()
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
        rank1stView.nameLabel.text = "이름"
        rank1stView.userImage.image = UIImage(named: "ashe")
        rank1stView.tierImage.image = UIImage(named: "platinum_5")
        rank1stView.scoreLabel.text = "score: 10000"
        view.addSubview(rank1stView)
        
        rank1stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank1stView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            rank1stView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rank1stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            rank1stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.38)
        ])
        
        rank2stView.rankLabel.text = "2 위"
        rank2stView.nameLabel.text = "이름2"
        rank2stView.userImage.image = UIImage(named: "ahri")
        rank2stView.tierImage.image = UIImage(named: "diamond_5")
        rank2stView.scoreLabel.text = "score: 9999"
        view.addSubview(rank2stView)
        
        rank2stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank2stView.topAnchor.constraint(equalTo: rank1stView.bottomAnchor, constant: 40),
            rank2stView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                  constant: -(view.frame.width/2 - (view.frame.width * 0.31))/2),
            rank2stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.23),
            rank2stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.31)
        ])
        
        rank3stView.rankLabel.text = "3 위"
        rank3stView.nameLabel.text = "이름3"
        rank3stView.userImage.image = UIImage(named: "elise")
        rank3stView.tierImage.image = UIImage(named: "gold_5")
        rank3stView.scoreLabel.text = "score: 8888"
        view.addSubview(rank3stView)

        rank3stView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rank3stView.topAnchor.constraint(equalTo: rank1stView.bottomAnchor, constant: 40),
            rank3stView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                  constant: (view.frame.width/2 - (view.frame.width * 0.31))/2),
            rank3stView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.23),
            rank3stView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.31)
        ])
    }
    
    // MARK: - Set Table
    
    func setTable(){
        rankingTable.rowHeight = 45
        rankingTable.allowsSelection = false
        rankingTable.separatorColor = .systemYellow
        rankingTable.backgroundColor = .clear
        rankingTable.dataSource = self
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserRankingCustomCell.identifier, for: indexPath) as! UserRankingCustomCell
        cell.backgroundColor = .clear
        cell.rankLabel.text = "\(indexPath.row + 1) 위"
        cell.nameLabel.text = "이름"
        cell.scoreLabel.text = "score: 10000"
        cell.tierImage.image = UIImage(named: "platinum_5")
        return cell
    }
}
