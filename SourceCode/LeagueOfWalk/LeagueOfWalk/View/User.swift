//
//  User.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class User {
  static let userId = "userId"
  static let nickName = "nickName"
  static let selectCharctor = "selectCharactor"
  static let warkingStatus = "warkingStatus"
  
  var uid: String!
  var nickName: String!
  var selectCharactor: String!
  var warkingStatus: Int = 0
  
  init(uid:String, dictionary: Dictionary<String, AnyObject> ) {
    self.uid = uid
    
    if let nickName = dictionary["nickName"] as? String {
      self.nickName = nickName
    }
    
    if let selectCharactor = dictionary["selectCharactor"] as? String {
      self.selectCharactor = selectCharactor
    }
  }
}