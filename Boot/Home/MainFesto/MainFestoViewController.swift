//
//  MainFestoViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 11/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit


class MainFestoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,PolicyCellDelegate{

    
    var arrPolicyData =  [PolicyData]()
    @IBOutlet var tblPolicyData:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tblPolicyData.rowHeight = UITableViewAutomaticDimension
        self.tblPolicyData.estimatedRowHeight = 500.0

        
        self.callGetPolicyData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WebService Call
    func callGetPolicyData()
    {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().getPolicyData(strAction: WebServiceConstans.Policy, strwbType: "POST", dict: [:]) { (dict) in
            
            ActivityController().hideActivityIndicator(uiView: self.view)
            let arrTempPolicy = dict.object(forKey: "policy_data") as? NSArray ?? NSArray()
            
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
            self.tblPolicyData.reloadData()
        }
    }
    
    //Mark UITableView In Swift
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPolicyData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "PolicyCell") as! PolicyCell
        cell.delegate = self
        cell.btnShare.tag = indexPath.row
        let objPolicyData = self.arrPolicyData[indexPath.row]
        cell.lblTitle.text =  objPolicyData.head
        cell.txtDes.text =  ViewBorder.shareViewBorder.stringFromHTML(strHtml: objPolicyData.descriptionPolicydata!)
        
        cell.txtDes.translatesAutoresizingMaskIntoConstraints = true
        cell.txtDes.sizeToFit()
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: UITableView Delegate
    
    func getIndexOfShareBtn(currentIndex: Int) {
        
        let objPolicyData = self.arrPolicyData[currentIndex]
        /*let text = objPolicyData.descriptionPolicydata!
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
         self.present(activityViewController, animated: true, completion: nil)*/
        
        
        ViewBorder.shareViewBorder.shareText(strShare: objPolicyData.descriptionPolicydata!, objview: self)
        
    }
    
    //MARK: UIButton Actions
    
    @IBAction func btnback(_sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
