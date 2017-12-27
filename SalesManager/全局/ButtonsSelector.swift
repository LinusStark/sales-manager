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
    
    let fontSize:CGFloat = 10
    let gap:CGFloat = 6
    var groupWidth:CGFloat = 0;
    var groupHeight:CGFloat = 0;
    
    public convenience init(frame: CGRect , datas:Array<Any>) {
        self.init(frame: frame)
        buttonDatas = datas as! Array<String>
        
        self.backgroundColor = UIColor.yellow
        
        self.layer.cornerRadius = 6
        
        if buttons == nil{
            buttons = Array.init()
        }
        if selectedDatas == nil
        {
            selectedDatas = Array.init()
        }
        
        var index:Int = 0
        let XYGap:CGFloat = 6
        
        var preX:CGFloat = 0 //上一个X位置
        var preY:CGFloat = 0 //上一个Y位置
        
        let buttonHeight:CGFloat = 22;
        
        
        for name in buttonDatas
        {
            let button:UIButton = UIButton.init(type: .custom)
            
            button.setTitle(name, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(clickButtonHandler(_:)), for: .touchUpInside)
            
            button.layer.cornerRadius = 4
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            
            
            let buttonWidth:CGFloat = fontSize * CGFloat(name.lengthOfBytes(using: String.Encoding.utf8))
            
            if (preX + buttonWidth + XYGap) > frame.width
            {
                if groupWidth < (preX - XYGap)
                {
                    groupWidth = preX - XYGap;
                }
                
                preY += (buttonHeight + XYGap)
                preX = 0
            }
            
            button.frame = CGRect(x: preX, y: preY, width: buttonWidth, height: buttonHeight)
            
            preX = preX + buttonWidth + XYGap;
            
            self.addSubview(button)
            
            buttons?.append(button)
            
            index += 1;
            
            if index == buttons?.count
            {
                groupHeight = button.frame.origin.y + button.frame.size.height
            }
            
        }
        
        
        let offsetX = (self.frame.size.width - groupWidth)/2
        let offsetY = (self.frame.size.height - groupHeight)/2
        
        for button in buttons!{
            button.center = CGPoint(x: button.center.x + offsetX, y: button.center.y + offsetY)
        }
        
    }
    
    @objc func clickButtonHandler(_ button:UIButton)
    {
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

}
