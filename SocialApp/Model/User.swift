//
//  User.swift
//  SocialApp
//
//  Created by 박경호 on 2023/09/11.
//

import Foundation
import Firebase

struct User {
    let email : String
    var fullname : String
    var profileImageUrl : String
    var username : String
    let uid : String
    
    var stats : UserStats!
    
    init(dictionary: [String : Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
//        self.fcmToken = dictionary["fcmToken"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0, post: 0)
    }
}

struct UserStats{
    let followers : Int
    let following : Int
    let post: Int
    
}
