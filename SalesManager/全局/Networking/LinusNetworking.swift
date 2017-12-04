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
import SwiftyJSON



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
        
        
        let phone:String? = Utils.getPhoneOrNil()
        var param:[String:Any]? = parameters
   
        if phone != nil
        {
            if param == nil
            {
                param = [NetKeyValue.PHONE:phone!]
            }else{
                if param![NetKeyValue.PHONE] == nil
                {
                    param?.updateValue(phone!, forKey: NetKeyValue.PHONE)
                }
            }

        }
        
        
        // 2.发送网络请求
        Alamofire.request(url, method: method, parameters: param).responseJSON { (response) in
            
            if showLoading == true
            {
                SwiftProgressHUD.hideAllHUD()
            }
            // 3.获取结果
            guard let result:NSDictionary = response.result.value as? NSDictionary else {
                print(response.result.error!)
                Utils.showToastTips("网络错误")
                
                if url.contains("/app/us") == true
                {
                    finishedCallback([NetKeyValue.ERROR_CODE:NSNumber(integerLiteral: 107)])
                }
                
                return
            }
            
            // 4.将结果回调出去
            
            let success = result.object(forKey: NetKeyValue.SUCCESS)
            let errorCode = result.object(forKey: NetKeyValue.ERROR_CODE)
            if ((errorCode is NSNull) == false && url.contains("phoneOnly") == false && url.contains("getCardInfo") == false) && url.contains("/app/us") == false && url.contains("eAccountQuery") == false//单独加上手机号判断
            {
                print(result)
                //表示有错;
                let error = result.object(forKey: NetKeyValue.ERROR) as! String
                
                let codeNumber:NSNumber = errorCode as! NSNumber
                
                let successNumber:NSNumber = success as! NSNumber
                
                if codeNumber.intValue == 8 && url.contains("/app/us") == true
                {
                    finishedCallback(result)
                }
                
                if url.contains("/wechat/wallet/hasPass") == true
                {
                    finishedCallback(result)
                    return;
                }
                
                if codeNumber.intValue == 38
                {
                    //未绑定银行卡
                    finishedCallback(result)
                }else if codeNumber.intValue == 0 && successNumber.intValue == 1
                {
                     finishedCallback(result)
                }else{
                    
                    if codeNumber.intValue == 9002
                    {
                        //退出登录
                        Utils.exitLogin();
                        
                        Utils.showToastTips("您的账号在别处登录")
                    }else{
                        
                        if error.contains("token") == false
                        {
                            Utils.showToastTips(error)
                        }
                    }
                }
                
            }else{
                //表示没错;
                finishedCallback(result)
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
    
    class func requestByProtogenesis(url:String, params:[String:Any])
    {
        let data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        var string = ""
        
        let Str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        //拼接
        string = string + Str!
        
        let Url = URL.init(string: url)
        
        let request = NSMutableURLRequest.init(url: Url!)
        
        request.timeoutInterval = 30
        //请求方式，跟OC一样的
        request.httpMethod = "POST"
        request.httpBody = string.data(using: String.Encoding.utf8)
        request.addValue("APPCODE 2ad2fdc5dd3948ba8c2c9883d7f655f7", forHTTPHeaderField:"Authorization")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                //此处是具体的解析，具体请移步下面
                let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
                if let value = JSON(json)["status"].string {
                    print("状态是：\(value)")
                }
                print(json)
            }
        }
        
        dataTask.resume()
        
        
    }
    
}
