//
//  CreateWaresTableViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/12/3.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class CreateWaresTableViewController: UITableViewController {
    let sections:Array<Int> = [2,2,2]
    
    
    var selectedColor:String?
    var selectedSize:String?
    var selectorColorButtons:ButtonsSelector?
    var selectorSizeButtons:ButtonsSelector?
    
    @IBOutlet var wareTableView: UITableView!
    
    @IBOutlet weak var wareNameText: UITextField!//名称
    @IBOutlet weak var wareNoText: UITextField!//货号
    @IBOutlet weak var purchasePriceText: UITextField!//采购价格
    @IBOutlet weak var retailPriceText: UITextField!//零售价格
    
    @IBOutlet weak var sizeContentView: UIView!
    @IBOutlet weak var colorContentView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.wareTableView.reloadData()
        
        let selectorColor = SharedInstance.instance.selectorColor
        
        let selectorWidth:CGFloat = Utils.kScreenWidth - 62 * 2
        if(selectorColor != nil)
        {
            let cellHeight:CGFloat = ButtonsSelector.getHeightByDatas(selectorColor!,sumWidth: selectorWidth) + 20
            if selectorColorButtons == nil{
                selectorColorButtons = ButtonsSelector.init(frame: CGRect(x:62,y:10,width:selectorWidth,height:cellHeight - 20), datas: selectorColor!)
                selectorColorButtons!.userEnable = false
            }else{
                
                selectorColorButtons?.frame = CGRect(x: 62, y: 10, width: selectorWidth, height: cellHeight - 20)
                
                selectorColorButtons!.update(selectorColor!)
            }
            self.colorContentView.addSubview(selectorColorButtons!)
        }
        
        let selectorSize = SharedInstance.instance.selectorSize
        
        if(selectorSize != nil)
        {
            let cellHeight:CGFloat = ButtonsSelector.getHeightByDatas(selectorSize!,sumWidth: selectorWidth) + 20
            if selectorSizeButtons == nil{
                selectorSizeButtons = ButtonsSelector.init(frame: CGRect(x:62,y:10,width:selectorWidth,height:cellHeight - 20), datas: selectorSize!)
                selectorSizeButtons!.userEnable = false
            }else{
                selectorSizeButtons?.frame = CGRect(x: 62, y: 10, width: selectorWidth, height: cellHeight - 20)
                selectorSizeButtons!.update(selectorSize!)
            }
            self.sizeContentView.addSubview(selectorSizeButtons!)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchResignHandler))
        
        self.wareTableView.addGestureRecognizer(tapGesture)

    }
    
    @IBAction func chooseColorHandler(_ sender: UIButton) {
        //选择颜色
        SharedInstance.instance.chooseTitle = "选择颜色"
        self.performSegue(withIdentifier: SegueiDentifiers.WARES_CREATE_GOTO_CHOOSE, sender: self)
        
    }
    
    @IBAction func chooseSizeHandler(_ sender: UIButton) {
        //选择尺码
        SharedInstance.instance.chooseTitle = "选择尺码"
        self.performSegue(withIdentifier: SegueiDentifiers.WARES_CREATE_GOTO_CHOOSE, sender: self)
    }
    
    @IBAction func backPopHandler(_ sender: UIBarButtonItem) {
        
        SharedInstance.instance.selectorColor = nil
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            let selectorDatas = SharedInstance.instance.selectorColor
            
            if(selectorDatas != nil)
            {
                let selectorWidth:CGFloat = Utils.kScreenWidth - 62 * 2
                let cellHeight:CGFloat = ButtonsSelector.getHeightByDatas(selectorDatas!,sumWidth: selectorWidth) + 20
                
                return cellHeight
            }
        }
        if(indexPath.section == 2 && indexPath.row == 1)
        {
            let selectorDatas = SharedInstance.instance.selectorSize
            
            if(selectorDatas != nil)
            {
                let selectorWidth:CGFloat = Utils.kScreenWidth - 62 * 2
                let cellHeight:CGFloat = ButtonsSelector.getHeightByDatas(selectorDatas!,sumWidth: selectorWidth) + 20
                
                return cellHeight
            }
        }
        
        return 50;
    }
    
    @objc func touchResignHandler() {
        wareNameText.resignFirstResponder()
        wareNoText.resignFirstResponder()
        purchasePriceText.resignFirstResponder()
        retailPriceText.resignFirstResponder()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
