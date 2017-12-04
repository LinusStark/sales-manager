//
//  Utils.swift
//  UnionWorker
//
//  Created by Linus on 2017/7/27.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit
import SwiftProgressHUD
import Kingfisher

class Utils:NSObject
{
    
    let kIOS7 = Double(UIDevice.version())>=7.0 ? 1 :0
    let kIOS8 = Double(UIDevice.version())>=8.0 ? 1 :0
    
    static let kScreenHeight = UIScreen.main.bounds.size.height
    static let kScreenWidth = UIScreen.main.bounds.size.width
    
    class func getScreenProPortion() -> CGFloat {
        
        
        let kScreenWidth = UIScreen.main.bounds.size.width
        let proportion = CGFloat(kScreenWidth / 375)
        
        return proportion
        
    }
    
    class func showToastTips(_ msg:String)
    {
        SwiftProgressHUD.showOnlyText(msg)
        
        /// 模拟 1s后 加载完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SwiftProgressHUD.fadeAllHUD()
        }
    }
    
    //验证码倒计时
    class func checkingButtonHandler(_ button:UIButton) {
        var timeout = 120
        
        let queue = DispatchQueue.init(label: "check_code_queue")
        
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        
        timer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        
        timer.setEventHandler {
            timeout -= 1
            
            if timeout <= 0{
                timer.cancel()
                
                DispatchQueue.main.async {
                    //更新资源
                    
                    button.setTitle("发送验证码", for: UIControlState.normal)
                    button.isUserInteractionEnabled = true
                }
                
            }else{
                DispatchQueue.main.async {
                    //更新资源
                    
                    button.setTitle("\(timeout)秒", for: UIControlState.normal)
                    button.isUserInteractionEnabled = false
                }
            }
        }
        
        timer.resume()
        
    }
    
    class func logImageByUrl(_ imageView:UIImageView, url:String , isRefresh:Bool = false){
        
        if url.contains("http")
        {
            if isRefresh == true
            {
                imageView.kf.setImage(with: URL(string: url) , placeholder: nil, options: [.transition(ImageTransition.fade(0.4)),.forceRefresh], progressBlock: { (receivedSize, totalSize) in
                    
                }, completionHandler: { (image, error, type, url) in
                    
                })
            }else{
                imageView.kf.setImage(with: URL(string: url) , placeholder: nil, options: [.transition(ImageTransition.fade(0.4))], progressBlock: { (receivedSize, totalSize) in
                    
                }, completionHandler: { (image, error, type, url) in
                    
                })
            }
            
            
            
        }else{
            imageView.image = UIImage(named: url)
        }
    }
    
    
    class func getViewControllerWithStoryBoardIdentifier(_ identifier:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        
        return vc
        
    }
    
    class func getViewControllerWithStoryBoardNameAndIdentifier(_ storyboardName:String,identifier:String)-> UIViewController{
        
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let vc  = storyBoard.instantiateViewController(withIdentifier: identifier)
        
        return vc
        
    }
    
    class func getRootViewControllerWithStoryBoardName(_ storyboardName:String)->UIViewController{
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let vc  = storyBoard.instantiateInitialViewController()
        
        return vc!
    }
    
    class func getUserDefaultWithKey(_ key:String) -> String?{
        
        let value = UserDefaults.standard.string(forKey: key)
        
        return value
    }
    
    class func setUserDefaultWithKey(_ key:String ,value:Any){
        
        UserDefaults.standard.set(value, forKey: key)
    }
    
    
    class func getGlobalUrl() -> String {
        
        let url = "http://39.106.47.199"//
        
        return url
    }
    
    class func getGlobalPageSize() -> Int
    {
        return 20
    }
    
    class func getCurrentVersion() -> String {
        
        // 得到当前应用的版本号
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        return currentAppVersion
    }
    
    
    class func gradualChangeColor(layer:CALayer , startColor:Int64, endColor:Int64)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Utils.kScreenWidth, height: layer.frame.size.height)
        
        //设置渐变的主颜色（可多个颜色添加）
        gradientLayer.colors = [UIColor.colorWithHex(hexColor: startColor).cgColor, UIColor.colorWithHex(hexColor: endColor).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        //将gradientLayer作为子layer添加到主layer上
        layer.addSublayer(gradientLayer)
        
        layer.masksToBounds = true
        
        layer.cornerRadius = 6
    }
    
    class func gradualChangeColorHomeTop(layer:CALayer)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Utils.kScreenWidth, height: layer.frame.size.height)
        
        let startColor = UIColor.colorWithHex(hexColor: 0xfd773c)
        let centerColor = UIColor.colorWithHex(hexColor: 0xfd773c)
        let endColor = UIColor.colorWithHex(hexColor: 0xffab65)
        
        //设置渐变的主颜色（可多个颜色添加）
        gradientLayer.colors = [startColor.cgColor,centerColor.cgColor,endColor.cgColor]
        
        gradientLayer.startPoint = CGPoint(x:0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        //将gradientLayer作为子layer添加到主layer上
        layer.addSublayer(gradientLayer)
    }
    

    class func isPutIntFloat(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
        
    }
    
    
    class func getGlobalColor()->Int64
    {
        return 0xf22332
    }
    
    class func checkIsIdentityCard(_ identityCard: String) -> Bool {
        //判断是否为空
        if identityCard.characters.count <= 0 {
            return false
        }
        //判断是否是18位，末尾是否是x
        let regex2: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", regex2)
        if !identityCardPredicate.evaluate(with: identityCard) {
            return false
        }
        //判断生日是否合法
        let range = NSRange(location: 6, length: 8)
        let datestr: String = (identityCard as NSString).substring(with: range)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if formatter.date(from: datestr) == nil {
            return false
        }
        //判断校验位
        if  identityCard.characters.count == 18 {
            let idCardWi: [String] = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
            //将前17位加权因子保存在数组里
            let idCardY: [String] = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            var idCardWiSum: Int = 0
            //用来保存前17位各自乖以加权因子后的总和
            for i in 0..<17 {
                idCardWiSum += Int((identityCard as NSString).substring(with: NSRange(location: i, length: 1)))! * Int(idCardWi[i])!
            }
            let idCardMod: Int = idCardWiSum % 11
            //计算出校验码所在数组的位置
            let idCardLast: String = identityCard.substring(from: identityCard.index(identityCard.endIndex, offsetBy: -1))
            //得到最后一位身份证号码
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if idCardMod == 2 {
                if idCardLast == "X" || idCardLast == "x" {
                    return true
                } else {
                    return false
                }
            } else {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if (idCardLast as NSString).integerValue == Int(idCardY[idCardMod]) {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
    
    
}



extension UILabel{
    
}

extension UIColor {
    
    class func colorWithHex(hexColor:Int64)->UIColor{
        
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
    
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    
    
}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}


extension UINavigationBar {
    // MARK: - 接口
    /**
     *  隐藏导航栏下的横线，背景色置空 viewWillAppear调用
     */
    func star() {
        let shadowImg: UIImageView? = self.findNavLineImageViewOn(view: self)
        shadowImg?.isHidden = true
        self.backgroundColor = nil
    }
    
    /**
     在func scrollViewDidScroll(_ scrollView: UIScrollView)调用
     @param color 最终显示颜色
     @param scrollView 当前滑动视图
     @param value 滑动临界值，依据需求设置
     */
    func change(_ color: UIColor, with scrollView: UIScrollView, andValue value: CGFloat) {
        if scrollView.contentOffset.y < -value{
            // 下拉时导航栏隐藏，无所谓，可以忽略
            self.isHidden = true
        } else {
            self.isHidden = false
            // 计算透明度
            let alpha: CGFloat = scrollView.contentOffset.y / value > 1.0 ? 1 : scrollView.contentOffset.y / value
            //设置一个颜色并转化为图片
            let image: UIImage? = imageFromColor(color: color.withAlphaComponent(alpha))
            self.setBackgroundImage(image, for: .default)
        }
    }
    
    /**
     *  还原导航栏  viewWillDisAppear调用
     */
    func reset() {
        let shadowImg = findNavLineImageViewOn(view: self)
        shadowImg?.isHidden = false
        self.setBackgroundImage(nil,for: .default)
    }
    
    // MARK: - 其他内部方法
    //寻找导航栏下的横线  （递归查询导航栏下边那条分割线）
    fileprivate func findNavLineImageViewOn(view: UIView) -> UIImageView? {
        if (view.isKind(of: UIImageView.classForCoder())  && view.bounds.size.height <= 1.0) {
            return view as? UIImageView
        }
        for subView in view.subviews {
            let imageView = findNavLineImageViewOn(view: subView)
            if imageView != nil {
                return imageView
            }
        }
        return nil
    }
    
    // 通过"UIColor"返回一张“UIImage”
    fileprivate func imageFromColor(color: UIColor) -> UIImage {
        //创建1像素区域并开始图片绘图
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        //创建画板并填充颜色和区域
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        //从画板上获取图片并关闭图片绘图
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}


