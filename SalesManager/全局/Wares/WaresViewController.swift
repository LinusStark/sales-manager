//
//  WaresViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/12/3.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class WaresViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var waresTableView: UITableView!
    
    var waresData:Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waresTableView.tableFooterView = UIView.init()
        
        waresTableView.rowHeight = 80
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if waresData == nil
        {
            waresData = SharedInstance.instance.waresDatas!
        }
        return waresData!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let data:[String:Any] = waresData[indexPath.row] as! [String:Any]
        let wareName:String = data[NetKeyValue.NAME] as! String;
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: iDentifiers.WARES_CELL)
        
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: iDentifiers.WARES_CELL)
        }
        
        cell?.selectionStyle = .none
        cell?.textLabel?.text = wareName
        
        return cell!
    }
    
    @IBAction func createWareHandler(_ sender: UIBarButtonItem) {
        //打开创建商品界面
        self.performSegue(withIdentifier: SegueiDentifiers.WARES_GOTO_CREATE_WARES, sender: self)
    }
    @IBAction func searchWaresHandler(_ sender: UIBarButtonItem) {
        //搜索商品
        Utils.showToastTips("搜索商品")
    }
    
    @IBAction func backCloseHandler(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
