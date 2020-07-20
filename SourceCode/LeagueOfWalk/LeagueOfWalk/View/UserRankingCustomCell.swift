//
//  UserRankingCustomCell.swift
//  LeagueOfWalk
//
//  Created by 표건욱 on 2020/07/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserRankingCustomCell: UITableViewCell {
    
    static let identifier = "identifier"
    let rankLabel = UILabel()
    let nameLabel = UILabel()
    
    let scoreLabel = UILabel()
    let tierImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setRankLabel()
        setNameLabel()
        setScoreLabel()
        setTierImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    private func setRankLabel(){
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont(name: CommonUI.CustonFonts.koFont.rawValue,
                                size: Standard.textSize)
        rankLabel.textColor = Standard.textColor
        contentView.addSubview(rankLabel)
    }
    private func setNameLabel(){
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: CommonUI.CustonFonts.koFont.rawValue,
                                size: Standard.textSize)
        nameLabel.textColor = Standard.textColor
        contentView.addSubview(nameLabel)
    }
    private func setScoreLabel(){
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: CommonUI.CustonFonts.koFont.rawValue,
                                 size: Standard.textSize)
        scoreLabel.textColor = Standard.textColor
        contentView.addSubview(scoreLabel)
    }
    private func setTierImage(){
        tierImage.contentMode = .scaleToFill
        tierImage.clipsToBounds = true
        contentView.addSubview(tierImage)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rankLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            rankLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            scoreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            scoreLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        tierImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tierImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tierImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tierImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            tierImage.heightAnchor.constraint(equalTo: tierImage.widthAnchor)
        ])
    }
}
