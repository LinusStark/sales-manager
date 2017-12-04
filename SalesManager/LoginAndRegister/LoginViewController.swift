//
//  LoginViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/11/26.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var topContainer: UIView!
    
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var topLogoImage:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        topLogoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: Utils.kScreenWidth, height: topContainer.frame.size.height))
        
        topLogoImage.contentMode = .scaleAspectFill
        
        Utils.logImageByUrl(topLogoImage, url: "https://wx1.sinaimg.cn/mw690/75614297ly1flnl8ufvioj234022nkjo.jpg", isRefresh: false)
        
        self.topContainer.addSubview(topLogoImage)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        topLogoImage.frame = CGRect(x: 0, y: 0, width: topContainer.frame.size.width, height: topContainer.frame.size.height)
    }
    
    @IBAction func showAndHidePasswordHandler(_ sender: UIButton) {
        //显示和隐藏密码
        sender.isSelected = !sender.isSelected
        
        self.passwordText.isSecureTextEntry = !self.passwordText.isSecureTextEntry
    }
    @IBAction func loginHandler(_ sender: UIButton) {
        //登录
        
        if judgeLogin() == false
        {
            return;
        }
        
        ServicesManager.userLogin(account: accountText.text!, password: passwordText.text!) { (result) in
            
            print(result)
            
            let data = result.object(forKey: NetKeyValue.DATA) as! [String:String]
            
            let userInfo:UserInfo = UserInfo.init(data)
            
            SharedInstance.instance.userInfo = userInfo
            
            Utils.setUserDefaultWithKey(LocationKeyValue.USER_TOKEN, value: userInfo.token!)
            
            Utils.showToastTips(ToastCn.LOGIN_SUCCESSED)
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func forgetPasswordHandler(_ sender: UIButton) {
        //忘记密码
    }
    
    @IBAction func registerAccountHandler(_ sender: UIButton) {
        //注册账号
        let registerVC = Utils.getViewControllerWithStoryBoardNameAndIdentifier(StoryBoardNames.LOGIN_AND_REGISTER, identifier: iDentifiers.REGISTER_VIEW)
        
        self.present(registerVC, animated: true, completion: nil)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        accountText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    func judgeLogin() -> Bool {
        
        if(accountText.text!.lengthOfBytes(using: String.Encoding.utf8) < 1)
        {
            Utils.showToastTips(ToastCn.PLEASE_INPUT_PHONE_NUMBER)
            accountText.becomeFirstResponder()
            return false
        }else if(accountText.text!.lengthOfBytes(using: String.Encoding.utf8) < 11)
        {
            Utils.showToastTips(ToastCn.PLEASE_INPUT_RIGHT_PHONE)
            accountText.becomeFirstResponder()
            return false
        }else if(passwordText.text!.lengthOfBytes(using: String.Encoding.utf8) < 1)
        {
            Utils.showToastTips(ToastCn.PLEASE_INPUT_PASSWORD)
            passwordText.becomeFirstResponder()
            return false
        }else if(passwordText.text!.lengthOfBytes(using: String.Encoding.utf8) < 6)
        {
            Utils.showToastTips(ToastCn.PLEASE_INPUT_RIGHT_PASSWORD)
            passwordText.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    
}
