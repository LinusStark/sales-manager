//
//  UserInfo.swift
//  SalesManager
//
//  Created by Linus on 2017/11/28.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    var userName:String?
    var expired:String?
    var mobile:String?
    var token:String?
    var userId:String?
    public convenience init(_ data:[String:String]){
        
        self.init()
        
        userName = data["userName"]
        expired = data["expired"]
        mobile = data["mobile"]
        token = data["token"]
        userId = data["userId"]
        
    }
    
}
