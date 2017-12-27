//
//  LinusNetworking.swift
//  UnionWorker
//
//  Created by Linus on 2017/7/27.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftProgressHUD



enum NetConfig{
    case TEST_CONFIGT
    case PRODUCTION_CONFIG
}

enum MethodType {
    case get
    case post
}

//测试环境
let environment = NetConfig.TEST_CONFIGT

class LinusNetworking {
    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, showLoading:Bool = true,finishedCallback :  @escaping (_ result : NSDictionary) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        var url:String
        
        if URLString .hasPrefix("http:") == false{
            url = environment == .TEST_CONFIGT ? "\(Utils.getGlobalUrl())\(URLString)" : ""
        }else{
            url = URLString
        }
        if showLoading == true
        {
            SwiftProgressHUD.showWait()
        }
        let param:[String:Any]? = parameters
        
        let token = SharedInstance.instance.userInfo?.token
        
        var headers:[String:String]
        if token == nil
        {
            headers = ["content-type":"application/json"]
        }else{
            headers = ["AUTH-TOKEN":token!,"content-type":"application/json"]
        }
        var encoding:ParameterEncoding
        if method == .post
        {
             encoding = JSONEncoding.default
        }else{
             encoding = URLEncoding.default
        }
        
        // 2.发送网络请求
        Alamofire.request(url, method: method, parameters: param,encoding:encoding,headers:headers).responseJSON { (response) in
            
            if showLoading == true
            {
                SwiftProgressHUD.hideAllHUD()
            }
            // 3.获取结果
            guard let result:NSDictionary = response.result.value as? NSDictionary else {
                print(response.result.error!)
                Utils.showToastTips("网络错误")
                
                return
            }
            let code:String = result.object(forKey: NetKeyValue.CODE) as! String
            if code == "200"
            {
                //表示没错;
                finishedCallback(result)
            }else{
                let msg = result.object(forKey: NetKeyValue.MESSAGE)
                
                if (msg is NSNull) == false
                {
                    Utils.showToastTips(msg as! String)
                }
                
                if code.contains("4-0001-00004") == true
                {
                    Utils.setUserDefaultWithKey(LocationKeyValue.USER_TOKEN, value: "");
                    
                    let vc = Utils.getCurrentViewController()
                    
                    let loginVC = Utils.getViewControllerWithStoryBoardNameAndIdentifier(StoryBoardNames.LOGIN_AND_REGISTER, identifier: iDentifiers.LOGIN_VIEW)
                    
                    vc.present(loginVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    class func upLoadImageRequest(urlString : String, params:[String:String], datas: [Data], names: [String],keys :[String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        let url = Utils.getGlobalUrl() + "\(urlString)"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let token = params[NetKeyValue.TOKEN]
            let phone = params[NetKeyValue.PHONE]
            
            multipartFormData.append((token?.data(using: String.Encoding.utf8)!)!, withName: NetKeyValue.TOKEN)
            multipartFormData.append((phone?.data(using: String.Encoding.utf8)!)!, withName: NetKeyValue.PHONE)
            
            for i in 0..<datas.count {
                multipartFormData.append(datas[i], withName: keys[i], fileName: names[i], mimeType: "image/png")
            }

        }, usingThreshold: UInt64.init(), to: url, method: HTTPMethod.post, headers: headers) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    if let myJson = response.result.value {
                        
                        let result = myJson as! NSDictionary
                        
                        success(result as! [String : AnyObject])
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                failture(encodingError)
            }
        }
        
    }
}
