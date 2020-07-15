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
  
  var uid: String!
  var userId: String!
  var nickName: String!
  var selectCharactor: String!
  
  init(uid:String, dictionary: Dictionary<String, AnyObject> ) {
    self.uid = uid
    
    if let userId = dictionary["userId"] as? String {
      self.userId = userId
    }
    
    if let nickName = dictionary["nickName"] as? String {
      self.nickName = nickName
    }
    
    if let selectCharactor = dictionary["selectCharactor"] as? String {
      self.selectCharactor = selectCharactor
    }
  }

}
