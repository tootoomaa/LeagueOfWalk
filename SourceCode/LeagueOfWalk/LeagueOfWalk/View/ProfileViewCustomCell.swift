//
//  ProfileViewCustomCell.swift
//  LeagueOfWalk
//
//  Created by 표건욱 on 2020/07/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ProfileViewCustomCell: UICollectionViewCell {
    
    static let identifier = "CustomItem"
    
    let itemImageView = UIImageView()
    let borderImageView = UIImageView()
    let itemTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        itemImageView.clipsToBounds = true
        contentView.addSubview(itemImageView)
        
        borderImageView.image = UIImage(named: "items_border_icon")
        contentView.addSubview(borderImageView)
        
        borderImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.centerXAnchor.constraint(equalTo: borderImageView.centerXAnchor),
            itemImageView.centerYAnchor.constraint(equalTo: borderImageView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalTo: borderImageView.widthAnchor, multiplier: 0.7),
            itemImageView.heightAnchor.constraint(equalTo: borderImageView.heightAnchor, multiplier: 0.7)
        ])
        
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.font = UIFont(name: CommonUI.CustonFonts.enFontRagular.rawValue,
                                     size: CommonUI.FontSize.Medium.rawValue)
        itemTitleLabel.textColor = Standard.textColor
        contentView.addSubview(itemTitleLabel)
        
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.centerXAnchor.constraint(equalTo: borderImageView.centerXAnchor),
            itemTitleLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor,
                                                    constant: contentView.frame.height / 3.25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
