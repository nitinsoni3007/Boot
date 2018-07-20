//
//  PolicyForamViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 11/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class PolicyForamViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var arrPolicyData =  [PolicyData]()
    @IBOutlet var tblPolicyForamData:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.tblPolicyForamData.rowHeight = UITableViewAutomaticDimension
        self.tblPolicyForamData.estimatedRowHeight = 500.0
        
         self.callGetPolicyData()
        // Do any additional setup after loading the view.
    }
    
    //MARK: WebService Call
    func callGetPolicyData()
    {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().getPolicyData(strAction: webServiceActions.Policy, strwbType: "POST", dict: [:]) { (dict) in
            
            ActivityController().hideActivityIndicator(uiView: self.view)
            let arrTempPolicy = dict.object(forKey: "policy_data") as! NSArray
            
            for (_,dict) in arrTempPolicy.enumerated()
            {
                let dictTemp:NSMutableDictionary =  dict as! NSMutableDictionary
                
                let objpolicyData =  PolicyData()
                objpolicyData.ID = dictTemp.object(forKey: "ID") as? String
                objpolicyData.SortNo = dictTemp.object(forKey: "SortNo") as? String
                objpolicyData.head = dictTemp.object(forKey: "head") as? String
                objpolicyData.descriptionPolicydata = dictTemp.object(forKey: "description") as? String
                objpolicyData.policyId = dictTemp.object(forKey: "policyId") as? String
                self.arrPolicyData.append(objpolicyData)
            }
            self.tblPolicyForamData.reloadData()
        }
    }
    
    
    //Mark UITableView In Swift
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPolicyData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "PolicyForamCell") as! PolicyForamCell
        let objPolicyData = self.arrPolicyData[indexPath.row]
        cell.lblTitle.text =  objPolicyData.head!
         return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: UIButton Actions
    
    @IBAction func btnBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
