//
//  SetPwdViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/11/26.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class SetPwdViewController: UIViewController {
    
    var account:String?
    
    @IBOutlet weak var accountText: UILabel!
    
    @IBOutlet weak var passwrodText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if account != nil
        {
            self.accountText.text = account
        }
        
    }
    @IBAction func registerHandler(_ sender: UIButton) {
        //注册
        
        ServicesManager.userRegister(account: account!, password: passwrodText.text!) { (result) in
            
            //注册成功返回
            Utils.showToastTips(ToastCn.REGISTER_SUCCESSED)
            
            var rootVC = self.presentingViewController
            while let parent = rootVC?.presentingViewController {
                rootVC = parent
            }
            //释放所有下级视图
            rootVC?.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func closeViewControllerHandler(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwrodText.resignFirstResponder()
    }
}
