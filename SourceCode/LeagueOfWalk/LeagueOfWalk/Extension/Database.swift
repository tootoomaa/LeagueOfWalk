
//
//  Database.swift
//  LeagueOfWalk
//
//  Created by 김광수 on 2020/07/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import Firebase

let USER_ITEM_REF = Database.database().reference().child("user-items")
let USER_ITEMPOPCOUNT_REF = Database.database().reference().child("user-items-popcount")

extension Database {
  
  static func fetchUserData(uid:String) {
    
    print("start fetch User \(uid)")
    
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
      print(snapshot)
      
      guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
      
      let user = User.init(uid: snapshot.key, dictionary: dictionary)

    }
    
//    return User
  }
  
  
  // MARK: - About Item Pop Count
  static func fetchUserPopItemCount(uid: String) -> Int {
    var count: Int = 0
    USER_ITEMPOPCOUNT_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
      guard let itemPopCount = snapshot.value as? Int else { return }
      
      count = itemPopCount
    }
    return count
  }
}
