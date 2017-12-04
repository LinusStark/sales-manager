//
//  ServicesManager.swift
//  SalesManager
//
//  Created by Linus on 2017/11/21.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

//获取数据类
class ServicesManager: NSObject {
    
    //获取商品
    class func searchItems(resultHandlerCallback :  @escaping (_ result : Array<Any>) -> ()){
        
        let param = [NetKeyValue.PAGE_SIZE:20] as [String : Any]
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_SEARCH_ITEMS, parameters: param, showLoading: true) { (result) in
            
            let data:[String:Any] = result.object(forKey: NetKeyValue.DATA) as! [String:Any]
            let waresData = data[NetKeyValue.RECORDS] as! Array<Any>
            resultHandlerCallback(waresData)
        }
    }
    
    //获取产品
    class func searchProducts(resultHandlerCallback :  @escaping (_ result : Array<Any>) -> ()){
        let param = [NetKeyValue.PAGE_SIZE:20] as [String : Any]
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_SEARCH_PRODUCTS, parameters: param, showLoading: true) { (result) in
            
            let data:[String:Any] = result.object(forKey: NetKeyValue.DATA) as! [String:Any]
            let waresData = data[NetKeyValue.RECORDS] as! Array<Any>
            resultHandlerCallback(waresData)
        }
    }
    
    //创建仓库
    class func createWarehouse(address:String, name:String, resultCallBackHandler: @escaping (_ result: NSDictionary) ->()) {
        
        let param = [NetKeyValue.ADDRESS:address,NetKeyValue.NAME:name
        ]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_CREATE_WAREHOUSE, parameters: param, showLoading: true) { (result) in
            
            resultCallBackHandler(result)
        }
        
    }
    
    class func userLogin(account:String,password:String,resultCallBackHandler:@escaping (_ result: NSDictionary)->()) {
        
        let param = [NetKeyValue.LOGIN:account,NetKeyValue.PASSWORD:password]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_USER_LOGIN, parameters: param, showLoading: true) { (result) in
            
            resultCallBackHandler(result)
            
        }
    }
    
    class func userRegister(account:String,password:String,resultCallBackHandler:@escaping (_ result: NSDictionary)->()) {
        
        let param = [NetKeyValue.MOBILE:account,NetKeyValue.PASSWORD:password,NetKeyValue.NICK_NAME:"新用户",NetKeyValue.NAME:account]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_USER_REGISTER, parameters: param, showLoading: true) { (result) in
            
            resultCallBackHandler(result)
        }
    }
    
    
    
}
