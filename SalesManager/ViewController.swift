//
//  ViewController.swift
//  SalesManager
//
//  Created by Linus on 2017/11/14.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var searchText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let datas:[[String:String]] = [[LocationKeyValue.GROUP_TITLE:"商品管理",LocationKeyValue.GROUP_IMAGE_URL:"commodity_management_icon"],[LocationKeyValue.GROUP_TITLE:"采购单",LocationKeyValue.GROUP_IMAGE_URL:"purchase_order_icon"],[LocationKeyValue.GROUP_TITLE:"销售单",LocationKeyValue.GROUP_IMAGE_URL:"sales_order_icon"],[LocationKeyValue.GROUP_TITLE:"库存查询",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"],[LocationKeyValue.GROUP_TITLE:"客户管理",LocationKeyValue.GROUP_IMAGE_URL:"customer_management_icon"],[LocationKeyValue.GROUP_TITLE:"经营概况",LocationKeyValue.GROUP_IMAGE_URL:"business_profile_icon"],[LocationKeyValue.GROUP_TITLE:"增值服务",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"],[LocationKeyValue.GROUP_TITLE:"推荐有奖",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"],[LocationKeyValue.GROUP_TITLE:"生意圈",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"],[LocationKeyValue.GROUP_TITLE:"创建仓库",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"],[LocationKeyValue.GROUP_TITLE:"",LocationKeyValue.GROUP_IMAGE_URL:"inventory_query_icon"]]
        
        
        var row = datas.count / 3
        
        if datas.count % row > 0
        {
            row = row + 1
        }
        
        let gWidth = self.view.frame.size.width
        let gHeight = (gWidth - 2)/3 * CGFloat(row)
        
        let gridGroup = GridGroupButton.init(frame: CGRect(x:0,y:0,width:gWidth,height:gHeight), datas: datas)
        
        
        gridGroup.touchHandler = {tagIndex in
            
            if tagIndex == datas.count - 2
            {
                ServicesManager.createWarehouse(address: "西山居", name: "仓库一号", resultCallBackHandler: { (result) in
                    
                    print(result)
                    
                    Utils.showToastTips("创建成功")
                    
                })
            }
            
            switch tagIndex {
            case 0:
                self.openWares()
                break;
            default:
                break;
            }
            
            
        }
        
        self.scrollContainer.addSubview(gridGroup)
        
        let token = Utils.getUserDefaultWithKey(LocationKeyValue.USER_TOKEN)
        
        if token == nil
        {
            let loginVC = Utils.getViewControllerWithStoryBoardNameAndIdentifier(StoryBoardNames.LOGIN_AND_REGISTER, identifier: iDentifiers.LOGIN_VIEW)
            self.present(loginVC, animated: true, completion: nil)
        }else{
            SharedInstance.instance.userInfo = UserInfo.init()
            SharedInstance.instance.userInfo?.token = token
        }
    }
    
    func openWares(){
        ServicesManager.searchProducts { (datas) in
            
            SharedInstance.instance.waresDatas = datas
            
            let vc = Utils.getRootViewControllerWithStoryBoardName(StoryBoardNames.WARES)

            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.colorWithHex(hexColor: 0x7AD4FA)
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.shadowImage = nil;
        
        self.view.backgroundColor = UIColor.colorWithHex(hexColor: 0xf5f7f9)
        
       
        
        
    }
    @IBAction func scanCodeHandler(_ sender: UIBarButtonItem) {
        //扫码按钮
        
        if  TARGET_IPHONE_SIMULATOR == 0
        {
            let scanBarcodeVC = ScanBarcodeViewController.init()
            
            self.present(scanBarcodeVC, animated: true, completion: nil)
        }else{
            Utils.showToastTips("模拟器无法打开相机")
        }
        
        
        
        
    }
    
    @IBAction func letfMoreHandler(_ sender: UIBarButtonItem) {
        //左上角更多按钮
        
//        ServicesManager.searchItems { (datas) in
//            
//            print(datas)
//        }
//        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

