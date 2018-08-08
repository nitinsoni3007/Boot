//
//  FinanceViewController.swift
//  Boot
//
//  Created by Nitin on 30/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class FinanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var btnDonate: UIButton!
    @IBOutlet weak var btnFinance: UIButton!
    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var tblDonate: UITableView!
    @IBOutlet weak var tblFinance: UITableView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameUnderline: UIView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var passwordUnderline: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    
    var arrDonateInfos = [Donate]()
    var selectedSectionDonate = -1
    var selectedSectionFinance = -1
    var selectedSection = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: WebServiceConstans.kAccountNumber){
            loginView.isHidden = true
        }
        var underlineFrame = underlineView.frame
        underlineFrame.size.width = view.bounds.width/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        svMain.contentSize = CGSize(width: svMain.bounds.width * 2, height: svMain.bounds.height)
        fetchDonateInfo()
    }
    
    func fetchDonateInfo() {
        ApiService().callApi(strAction: "donate", strWebType: "GET", params: [String:String]()) { (resp) in
            let donateInfoDicts = resp as! [[String: String]]
            self.arrDonateInfos = donateInfoDicts.map({Donate(object: $0)}) as! [Donate]
            self.selectedSection = self.selectedSectionDonate
            self.tblDonate.reloadData()
            self.tblFinance.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        if areDataValid() {
            let postString = "email=\(txtUsername.text!)&password=\(txtPassword.text!)&clicked_on="
            ApiService().callApiPost(strAction: WebServiceConstans.ProfileLogin, strWebType: "POST", paramsString: postString) { (resp) in
                let responseDict = (resp as! [String:AnyObject])["response"] as! [String: AnyObject]
                if let status = responseDict["status"] as? Int {
                    if status == 0{
                        self.showMessage(withMessage: responseDict["message"] as? String ?? "Invalid credentials")
                    }else {
                        if let acctNo = responseDict[WebServiceConstans.kAccountNumber] as? String {
                            UserDefaults.standard.setValue(acctNo, forKey: WebServiceConstans.kAccountNumber)
                        }
                        if let is_liked = responseDict[WebServiceConstans.kIsLiked] as? String {
                            UserDefaults.standard.setValue(is_liked, forKey: WebServiceConstans.kIsLiked)
                        }
                        if let is_voted = responseDict[WebServiceConstans.kIsVoted] as? String {
                            UserDefaults.standard.setValue(is_voted, forKey: WebServiceConstans.kIsVoted)
                        }
                        
                        self.loginView.isHidden = true
                        
                    }
                }
            }
        }
    }
    
    func areDataValid() -> Bool {
        var flag = false
        if txtUsername.text?.isBlank == false {
            if txtUsername.text?.isEmail ?? false {
                flag = true
            }else {
                showMessage(withMessage: "Email is not valid")
                return false
            }
        }else {
            showMessage(withMessage: "Please enter a uername")
            return false
        }
        
        if txtPassword.text?.isBlank == false {
            flag = true
        }else {
            showMessage(withMessage: "Please enter a password")
            return false
        }
        return flag
    }
    
    func showMessage(withMessage msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnDonateAction(_ sender: Any) {
        btnDonate.setTitleColor(UIColor.red, for: .normal)
        btnFinance.setTitleColor(UIColor.black, for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.underlineView.center = CGPoint(x: self.btnDonate.center.x, y: self.underlineView.center.y)
        }
        svMain.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func btnFinanceAction(_ sender: Any) {
        btnDonate.setTitleColor(UIColor.black, for: .normal)
        btnFinance.setTitleColor(UIColor.red, for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.underlineView.center = CGPoint(x: self.btnFinance.center.x, y: self.underlineView.center.y)
        }
        svMain.setContentOffset(CGPoint(x: svMain.bounds.width, y: 0), animated: true)
    }
    
    //MARK: tableview delegate and datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrDonateInfos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSection == -1 || selectedSection != section {
        return 0
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let donateInfo = arrDonateInfos[indexPath.section]
        if tableView == tblDonate {
            let cellId = "IntroCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            let lblTitle = cell?.contentView.viewWithTag(101) as! UILabel
            lblTitle.text = donateInfo.bankAccountNumber
            let textView = cell?.contentView.viewWithTag(102) as! UITextView
            textView.text = ViewBorder.shareViewBorder.stringFromHTML(strHtml: donateInfo.donateInstruction ?? "")
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            return cell!
        }else {
            let cellId = "PhilosophyCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            let lblTitle = cell?.contentView.viewWithTag(201) as! UILabel
            lblTitle.text = donateInfo.bankAccountNumber
            let textView = cell?.contentView.viewWithTag(202) as! UITextView
            textView.text = ViewBorder.shareViewBorder.stringFromHTML(strHtml: donateInfo.paymentInstruction ?? "")
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x:0, y: 0, width: view.bounds.width, height: 40))
        headerView.backgroundColor = UIColor.white
        let btnSection = UIButton(frame: CGRect(x: 8, y: 0, width: view.bounds.width - 16, height: 40))
        btnSection.backgroundColor = UIColor.white
        btnSection.setTitleColor("#800000".colorFromHeX(), for: .normal)
       // btnSection.setTitleColor(UIColor.red, for: .normal)
        btnSection.contentHorizontalAlignment = .left
        btnSection.setTitle(arrDonateInfos[section].bankAccountName, for: .normal)
        btnSection.tag = section
        if tableView == tblDonate {
        btnSection.addTarget(self, action: #selector(btnSectionDonateAction(_:)), for: .touchUpInside)
        }else {
            btnSection.addTarget(self, action: #selector(btnSectionFinanceAction(_:)), for: .touchUpInside)
        }
        headerView.addSubview(btnSection)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func btnSectionDonateAction(_ sender: UIButton) {
        let btnTag = sender.tag
        resetDonateTable(forIndex: btnTag)
    }
    
    @objc func btnSectionFinanceAction(_ sender: UIButton) {
        let btnTag = sender.tag
        resetFinanceTable(forIndex: btnTag)
    }
//    var openedSectionTag = -1
    func resetDonateTable(forIndex ind:Int) {
        if selectedSectionDonate == ind {
            selectedSectionDonate = -1
        }else {
            selectedSectionDonate = ind
        }
        selectedSection = selectedSectionDonate
        tblDonate.reloadData()
    }
    
    func resetFinanceTable(forIndex ind:Int) {
        if selectedSectionFinance == ind {
            selectedSectionFinance = -1
        }else {
            selectedSectionFinance = ind
        }
        selectedSection = selectedSectionFinance
        tblFinance.reloadData()
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == svMain {
            if scrollView.contentOffset.x == 0 {
                btnDonate.setTitleColor(UIColor.red, for: .normal)
                btnFinance.setTitleColor(UIColor.black, for: .normal)
                UIView.animate(withDuration: 0.3) {
                    self.underlineView.center = CGPoint(x: self.btnDonate.center.x, y: self.underlineView.center.y)
                }
            }else if scrollView.contentOffset.x >= svMain.bounds.width{
                btnDonate.setTitleColor(UIColor.black, for: .normal)
                btnFinance.setTitleColor(UIColor.red, for: .normal)
                UIView.animate(withDuration: 0.3) {
                    self.underlineView.center = CGPoint(x: self.btnFinance.center.x, y: self.underlineView.center.y)
                }
            }
        }
    }
    
    //MARK: textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtUsername {
        usernameUnderline.backgroundColor = UIColor.green
            passwordUnderline.backgroundColor = UIColor.gray
        }else {
            passwordUnderline.backgroundColor = UIColor.green
            usernameUnderline.backgroundColor = UIColor.gray
        }
    }
    
    
}
