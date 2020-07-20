//
//  Item.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class Item {
  static let name = "name"
  static let information = "information"
  static let imageUrl = "imageUrl"
  
  var index: String!
  var name: String!
  var information: String!
  var imageUrl: URL!
  
  init(forIndex index: String, dictionary: Dictionary<String, AnyObject> ) {
    
    self.index = index
    
    if let name = dictionary["name"] as? String {
      self.name = name
    }
    
    if let information = dictionary["infomation"] as? String {
      self.information = information
    }
    
    if let imageUrl = dictionary["imageUrl"] as? URL {
      self.imageUrl = imageUrl
    }
  }
}
