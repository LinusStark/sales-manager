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
        
        let param = [NetKeyValue.PAGE_SIZE:10]
        LinusNetworking.requestData(.get, URLString: NetUrl.GET_SEARCH_ITEMS, parameters: param, showLoading: true) { (result) in
            
            
            print(result)
            
        }
    }
    //创建仓库
    class func createWarehouse(address:String, name:String, resultCallBackHandler: @escaping (_ result: NSDictionary) ->()) {
        
        let param = [NetKeyValue.ADDRESS:address,NetKeyValue.NAME:name
        ]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_CREATE_WAREHOUSE, parameters: param, showLoading: true) { (result) in
            
            let code:String = result.object(forKey: NetKeyValue.CODE) as! String
            
            if code == "200"
            {
                //表示没错;
                resultCallBackHandler(result)
            }else{
                let msg = result.object(forKey: NetKeyValue.MESSAGE)
                if (msg is NSNull) == false
                {
                    Utils.showToastTips(msg as! String)
                }
            }
        }
        
    }
    
    class func userLogin(account:String,password:String,resultCallBackHandler:@escaping (_ result: NSDictionary)->()) {
        
        let param = [NetKeyValue.LOGIN:account,NetKeyValue.PASSWORD:password]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_USER_LOGIN, parameters: param, showLoading: true) { (result) in
            
            let code:String = result.object(forKey: NetKeyValue.CODE) as! String
            
            if code == "200"
            {
                //登录成功返回token
                resultCallBackHandler(result)
            }else{
                let msg = result.object(forKey: NetKeyValue.MESSAGE)
                if (msg is NSNull) == false
                {
                    Utils.showToastTips(msg as! String)
                }
            }
            
        }
    }
    
    class func userRegister(account:String,password:String,resultCallBackHandler:@escaping (_ result: NSDictionary)->()) {
        
        let param = [NetKeyValue.MOBILE:account,NetKeyValue.PASSWORD:password,NetKeyValue.NICK_NAME:"新用户",NetKeyValue.NAME:account]
        
        LinusNetworking.requestData(.post, URLString: NetUrl.POST_USER_REGISTER, parameters: param, showLoading: true) { (result) in
            let code:String = result.object(forKey: NetKeyValue.CODE) as! String
            
            if code == "200"
            {
                //注册成功
                resultCallBackHandler(result)
            }else{
                let msg = result.object(forKey: NetKeyValue.MESSAGE)
                if (msg is NSNull) == false
                {
                    Utils.showToastTips(msg as! String)
                }
            }
        }
    }
    
    //获取自己商品列表
    class func getSelfWares(resultCallBackHandler:@escaping (_ result:NSDictionary) -> ()) {
        
    }
    
}
