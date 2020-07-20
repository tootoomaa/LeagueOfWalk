//
//  UserRankingView.swift
//  LeagueOfWalk
//
//  Created by 표건욱 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserRankingView: UIView {
    
    var userData: User? {
      didSet {
        guard let userData = userData else { return }
        nameLabel.text = userData.nickName
        scoreLabel.text = "score: \(Int(userData.walkingStatus))"
        userImage.image = UIImage(named: userData.selectCharactor)
      }
    }
  
    let containerView = UIView()
    
    let rankLabel = UILabel()
    let nameLabel = UILabel()
    
    let userImage = UIImageView()
    let tierImage = UIImageView()
    
    let scoreLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 0.75
        containerView.layer.borderColor = UIColor.systemYellow.cgColor
        containerView.backgroundColor = CommonUI.pointColor
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setRankLabel()
        setNameLabel()
        setUserImage()
        setTierImage()
        setScoreLabel()
    }
    private func setRankLabel(){
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont(name: CommonUI.CustonFonts.koFont.rawValue,
                                size: Standard.textSize)
        rankLabel.textColor = Standard.textColor
        self.addSubview(rankLabel)
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            rankLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3),
            rankLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.125)
        ])
    }
    private func setNameLabel(){
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: CommonUI.CustonFonts.koFont.rawValue,
                                size: Standard.textSize)
        nameLabel.textColor = Standard.textColor
        self.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: rankLabel.bottomAnchor)
        ])
    }
    private func setUserImage(){
        userImage.layer.borderWidth = 0.75
        userImage.layer.borderColor = UIColor.systemYellow.cgColor
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        containerView.addSubview(userImage)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.725)
        ])
    }
    private func setTierImage(){
        tierImage.contentMode = .scaleAspectFill
        tierImage.clipsToBounds = true
        containerView.addSubview(tierImage)
        
        tierImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tierImage.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            tierImage.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
            tierImage.widthAnchor.constraint(equalTo: userImage.widthAnchor, multiplier: 0.3),
            tierImage.heightAnchor.constraint(equalTo: tierImage.widthAnchor)
        ])
    }
    private func setScoreLabel(){
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: CommonUI.CustonFonts.enFontRagular.rawValue,
                                 size: Standard.textSize)
        scoreLabel.textColor = Standard.textColor
        containerView.addSubview(scoreLabel)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
