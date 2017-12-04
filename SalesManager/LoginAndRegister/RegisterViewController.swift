//
//  RegisterViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/11/26.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var accountText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func nextHandler(_ sender: UIButton) {
        //下一步
        if judgeAccount() == false
        {
            return
        }
        
        let setPwdVC:SetPwdViewController = Utils.getViewControllerWithStoryBoardNameAndIdentifier(StoryBoardNames.LOGIN_AND_REGISTER, identifier: iDentifiers.SET_PWD_VIEW) as! SetPwdViewController
        
        setPwdVC.account = self.accountText.text
        
        self.present(setPwdVC, animated: true, completion: nil)
        
    }
    @IBAction func closeViewControllerHandler(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func judgeAccount() -> Bool {
        
        if (accountText.text?.lengthOfBytes(using: String.Encoding.utf8))! < 1{
            Utils.showToastTips(ToastCn.PLEASE_INPUT_PHONE_NUMBER)
            return false;
        }
        
        if (accountText.text?.lengthOfBytes(using: String.Encoding.utf8))! < 11{
            Utils.showToastTips(ToastCn.PLEASE_INPUT_RIGHT_PHONE)
            return false;
        }
        return true;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.accountText.resignFirstResponder()
    }
}
