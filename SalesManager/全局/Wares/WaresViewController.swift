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
    override func viewDidLoad() {
        super.viewDidLoad()

        waresTableView.tableFooterView = UIView.init()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return UITableViewCell.init()
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
