//
//  SelectCharCell.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectCharCell: UICollectionViewCell {
    
  // MARK: - Properties
  static let identifier = "SelectCharCell"
  
  var charName: String? {
    didSet {
      guard let charName = charName else { return }
      
      charNameLabel.text = charName
      charImageView.image = UIImage(named: charName)
      
    }
  }
  
  let charImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Garen")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = CommonUI.pointColor
    return imageView
  }()
  
  let charNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Garen"
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = CommonUI.edgeColor
    label.textAlignment = .center
    label.backgroundColor = .darkGray
    label.sizeToFit()
    return label
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .blue
    
    configureLayout()
  }
  
  func configureLayout() {
    [charImageView, charNameLabel].forEach{
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      charImageView.topAnchor.constraint(equalTo: topAnchor),
      charNameLabel.topAnchor.constraint(equalTo: charImageView.bottomAnchor),
      charNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      charNameLabel.heightAnchor.constraint(equalToConstant: 25)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
