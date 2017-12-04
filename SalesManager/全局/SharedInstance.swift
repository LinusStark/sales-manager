//
//  SharedInstance.swift
//  UnionWorker
//
//  Created by Linus on 2017/8/1.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class SharedInstance: NSObject {
    
    static let instance = SharedInstance()
    
    var userInfo:UserInfo?
    
}
