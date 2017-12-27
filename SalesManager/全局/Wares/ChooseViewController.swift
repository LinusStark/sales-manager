//
//  ChooseViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/12/26.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let sections:Array<Int> = [1]
    let itemHeight:CGFloat = 22
    var cellHeight:CGFloat?
    var dataSource:Array<String>?
    var selector:ButtonsSelector!
    @IBOutlet weak var chooseTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = ["赤红色","橙色","黄色","绿色","青色","蓝青色","紫色","黑色","白色"]
        
        selector = ButtonsSelector.init(frame: CGRect(x: 0, y: 0, width: Utils.kScreenWidth, height: cellHeight!), datas: dataSource!)
        
        cellHeight = selector.groupHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chooseTableView.delegate = self
        self.chooseTableView.dataSource = self
    }
    @IBAction func backPopHandler(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func confirmHandler(_ sender: UIBarButtonItem) {
        //确认;
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sections[section]
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let selectorCell = "selectorCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: selectorCell)
        
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: selectorCell)
        }
        
        cell?.contentView .addSubview(selector)
        
        return cell!
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return cellHeight!
    }

}
