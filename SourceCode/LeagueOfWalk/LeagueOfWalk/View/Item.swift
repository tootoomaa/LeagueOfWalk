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
//  static let option = "option"
//  static let information = "information"
  
  var index: String!
  var name: String!
//  var option: String!
//  var information: String!
  
  init(forIndex index: String, name: String ) {  // dictionary: Dictionary<String, AnyObject>
    
    self.index = index
    
    self.name = name
    
//    if let name = dictionary["name"] as? String {
//      self.name = name
//    }
    
//    if let option = dictionary["option"] as? String {
//      self.option = option
//    }
//
//    if let information = dictionary["infomation"] as? String {
//      self.information = information
//    }
  }
}



