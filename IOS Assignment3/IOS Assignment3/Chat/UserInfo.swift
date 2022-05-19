//
//  UserInfo.swift
//  IOS Assignment3
//
//  Created by Xueyan Yang on 2022/5/15.
//

import UIKit

class UserInfo: NSObject {
    
    var username: String = ""
    var avatar: String = ""
    
    init(name: String, avatar: String) {
        self.username = name
        self.avatar = avatar;
    }
    
}
