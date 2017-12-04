//
//  GridGroupButton.swift
//  SalesManager
//
//  Created by Linus on 2017/11/14.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class GridGroupButton: UIView {

    let col:Int = 3
    var row:Int!
    var gridWidth:CGFloat!
    var gridHeight:CGFloat!
    let gridGap:CGFloat = 1.0
    var viewWH:CGFloat!
    
    let TAG:Int = 100
    
    typealias touchByTag = (Int)->()
    
    var touchHandler:touchByTag?
    
    
    public convenience init(frame: CGRect , datas:[[String:String]]) {
        self.init(frame: frame)
        
        gridWidth = frame.size.width
        gridHeight = frame.size.height
        
        viewWH = (gridWidth - 2)/3
        
        row = datas.count / col
        
        if datas.count % col > 0
        {
            row = row + 1
        }
        var index = 0;
        for i:Int in 0..<row
        {
            for j:Int in 0..<col
            {
                let view:UIView = UIView.init(frame: CGRect(x: CGFloat(j)*viewWH + CGFloat(j)*gridGap, y: CGFloat(i)*viewWH + CGFloat(i)*gridGap, width: viewWH, height: viewWH))
                view.backgroundColor = UIColor.white
                
                if datas.count == index{
                    break;
                }
                
                let data:[String:String]? = datas[index]
                
                if data == nil
                {
                    break;
                }
                
                let imageUrl = data![LocationKeyValue.GROUP_IMAGE_URL]
                let title = data![LocationKeyValue.GROUP_TITLE]
                
                let image = UIImageView.init(frame: CGRect(x: 0, y: 0, width: viewWH - viewWH/1.3, height: viewWH - viewWH/1.3))
                image.image = UIImage.init(named: imageUrl!)
                
                image.center = CGPoint(x: viewWH/2, y: viewWH/2)
                
                view.addSubview(image);
                
                let titleLabel = UILabel.init(frame: CGRect(x: 0, y: image.frame.origin.y + image.frame.size.height + 4, width: viewWH, height: 25))
                
                titleLabel.text = title!
                
                titleLabel.font = UIFont.systemFont(ofSize: 13)
                
                titleLabel.textAlignment = .center
                
                view.addSubview(titleLabel)
                
                view.tag = index + TAG
                
                self.addSubview(view)
                
                let gesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapForIndexHandler))
                
                view.isUserInteractionEnabled = true
                
                view.addGestureRecognizer(gesture)
                
                
                index += 1
            }
        }
        
    }
    
    
    
    @objc func tapForIndexHandler(_ gesture:UITapGestureRecognizer) {
        
        let index = gesture.view!.tag - TAG
        
        print(index)
        
        self.touchHandler?(index)
    }

}
