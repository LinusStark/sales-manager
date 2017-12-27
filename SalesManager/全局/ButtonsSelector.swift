//
//  ButtonsSelector.swift
//  SalesManager
//
//  Created by Linus on 2017/12/4.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class ButtonsSelector: UIView {

    var buttonDatas:Array<String>!
    var buttons:Array<UIButton>?
    
    var selectedDatas:Array<String>?
    
    static let fontSize:CGFloat = 12
    let gap:CGFloat = 6
    var groupWidth:CGFloat = 0;
    var groupHeight:CGFloat = 0;
    static let buttonHeight:CGFloat = 21;
    static let XYGap:CGFloat = 6
    var userEnable:Bool = true
    
    public convenience init(frame: CGRect , datas:Array<Any>) {
        self.init(frame: frame)
        buttonDatas = datas as! Array<String>
        
        self.layer.cornerRadius = 6
        
        if buttons == nil{
            buttons = Array.init()
        }
        if selectedDatas == nil
        {
            selectedDatas = Array.init()
        }
        self.setButtonLocationAndRegister()
    }
    
    @objc func clickButtonHandler(_ button:UIButton)
    {
        if userEnable == false
        {
            return
        }
        button.isSelected = !button.isSelected
        
        if button.isSelected == true
        {
            button.backgroundColor = UIColor.orange
            //选中状态
            selectedDatas?.append((button.titleLabel?.text)!)
            
        }else{
            button.backgroundColor = UIColor.white
            let index:Int = (selectedDatas?.index(of: (button.titleLabel?.text)!))!
            selectedDatas?.remove(at: index)
        }
    }
    
    func update(_ datas:[String]) {
        
        for button in buttons!{
            button.removeFromSuperview()
        }
        
        buttons = Array.init()
        selectedDatas = Array.init()
        buttonDatas = datas
        
        self.setButtonLocationAndRegister()
   
    }
    
    func setButtonLocationAndRegister()
    {
        var index:Int = 0
        var preX:CGFloat = 0 //上一个X位置
        var preY:CGFloat = 0 //上一个Y位置
        
        for name in buttonDatas
        {
            let button:UIButton = UIButton.init(type: .custom)
            
            button.setTitle(name, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(clickButtonHandler(_:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: ButtonsSelector.fontSize)
            button.layer.cornerRadius = 4
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            
            
            let buttonWidth:CGFloat = ButtonsSelector.fontSize * CGFloat(name.count) + 10
            
            if (preX + buttonWidth + ButtonsSelector.XYGap) > frame.width
            {
                preY += (ButtonsSelector.buttonHeight + ButtonsSelector.XYGap)
                preX = 0
            }
            
            button.frame = CGRect(x: preX, y: preY, width: buttonWidth, height: ButtonsSelector.buttonHeight)
            
            preX = preX + buttonWidth + ButtonsSelector.XYGap;
            if groupWidth < (preX - ButtonsSelector.XYGap)
            {
                groupWidth = preX - ButtonsSelector.XYGap;
            }
            
            self.addSubview(button)
            
            buttons?.append(button)
            
            index += 1;
            
            if index == buttons?.count
            {
                groupHeight = button.frame.origin.y + button.frame.size.height
            }
            
        }
        
        print(groupWidth,groupHeight)
        let offsetX = (self.frame.size.width - groupWidth)/2
        let offsetY = (self.frame.size.height - groupHeight)/2
        
        for button in buttons!{
            button.center = CGPoint(x: button.center.x + offsetX, y: button.center.y + offsetY)
        }
    }
    
    class func getHeightByDatas(_ datas:Array<String>,sumWidth:CGFloat)->(CGFloat){
        
        var currentWidth:CGFloat = 0
        var sumHeight:CGFloat = buttonHeight
        
        for key in datas{
            
            let width = fontSize * CGFloat(key.count) + 10
            currentWidth = currentWidth + width + XYGap
            
            if(currentWidth > sumWidth)
            {
                sumHeight = sumHeight + buttonHeight + XYGap
                currentWidth = 0
            }
        }
        
        return sumHeight
        
    }

}



