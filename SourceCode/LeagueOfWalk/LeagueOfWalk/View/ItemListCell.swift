//
//  ItemListCell.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Foundation

class ItemListCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let identifier = "ItemListCell"
  
  var itemData: Item? {
    didSet {
      guard let itemData = itemData else { return }
      
      // 아이탬 이름의 길이 확인
//      let stringWidth = itemData.name.widthOfString(usingFont: UIFont.boldSystemFont(ofSize: 13))
//      
//      // cell의 넒이보다 큰 경우 10포인트 조절
//      if contentView.frame.width < stringWidth {
//        itemNameLabel.font = .boldSystemFont(ofSize: 10)
//      }
      
      // 이름 적용
      itemNameLabel.text = itemData.name
      
      // 이미지 저장
      guard let url = itemData.imageUrl else { return }
      let getImageData = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("error", error.localizedDescription)
          return
        }
        
        guard let data = data else { return }
        DispatchQueue.main.async {
          self.itemImageView.image = UIImage(data: data)
        }
      })
      getImageData.resume()
    }
  }

  
  let itemImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "3384") //3384
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = CommonUI.pointColor
    return imageView
  }()
  
  let itemNameLabel: UILabel = {
    let label = UILabel()
    label.text = "삼위일체"
    label.font = .boldSystemFont(ofSize: 13)
    label.textColor = CommonUI.edgeColor
    label.textAlignment = .center
    label.backgroundColor = .darkGray
    label.sizeToFit()
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .blue
    
    configureLayout()
    
  }
  
  func configureLayout() {
  
    [itemImageView, itemNameLabel].forEach{
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      itemImageView.topAnchor.constraint(equalTo: topAnchor),
      
      itemNameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
      itemNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      itemNameLabel.heightAnchor.constraint(equalTo: itemImageView.heightAnchor, multiplier: 0.3)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
