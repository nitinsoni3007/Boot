//
//  VoteWareViewController.swift
//  Boot
//
//  Created by Nitin on 31/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class VoteWareViewController: UIViewController {
    
    @IBOutlet weak var txtUserNameVoter: UITextField!
    @IBOutlet weak var txtPasswordVoter: UITextField!
    @IBOutlet weak var txtTokenPassVoter: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var voterLoginView: UIView!
    @IBOutlet weak var adminLoginView: UIView!
    @IBOutlet weak var txtAdminUsername: UITextField!
    @IBOutlet weak var txtPassAdmin: UITextField!
    @IBOutlet weak var txtAdminPasskey: UITextField!
    @IBOutlet weak var baseLoginView: UIView!
    
    @IBOutlet weak var btnClickToVote: UIButton!
    @IBOutlet weak var btnLoginAdmin: UIButton!
    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginAdmin.isEnabled = false
        btnLogin.layer.cornerRadius = 6.0
        btnLogin.clipsToBounds = true
        //        if UserDefaults.standard.bool(forKey: WebServiceConstans.kIsAdmin) == false {
        adminLoginView.isHidden = true
        btnClickToVote.isEnabled = false
        //        }else {
        //            fetchAdmin()
        //        }
        NotificationCenter.default.addObserver(self, selector: #selector(logoutVoter), name: NSNotification.Name(rawValue: WebServiceConstans.kNotificationLogVoterOut), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    var admin: Admin?
    
    func fetchBallotLikeContent() {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApi(strAction: WebServiceConstans.BallotLike, strWebType: "GET", params: [:], complition: { (dict) in
            ActivityController().hideActivityIndicator(uiView: self.view)
            if let dictSate:NSMutableDictionary =  dict as? NSMutableDictionary {
                let dictContent = dictSate.object(forKey: "ballotlike_data") as! [String: String]
                let ballotContent = BallotLike(object: dictContent) as! BallotLike
                self.lblBallotLikeTitle.text = ballotContent.likeHeading
                self.webviewContent.loadHTMLString(ballotContent.likeContent ?? "", baseURL: nil)
                self.btnClickToVote.isEnabled = true
            }
        })
    }
    
    //    func fetchAdmin() {
//            ApiService().callApi(strAction: WebServiceConstans.AdminIEMINumber, strWebType: "GET", params: [:], complition: { (dict) in
//
//                if let dictSate:NSMutableDictionary =  dict as? NSMutableDictionary {
//                    let arrDicts = dictSate.object(forKey: "response") as! NSArray
//                    let admins = arrDicts.map({Admin.init(object: $0)})
//                    self.admin = admins.filter({$0.imeiNumber! == UIDevice.current.identifierForVendor!.uuidString}).first
//                    self.btnLoginAdmin.isEnabled = true
//                }
//            })
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginVoterAction(_ sender: Any) {
        if self.areVoterDataValid() {
            let isAdmin = false
            //            if UserDefaults.standard.bool(forKey: WebServiceConstans.kIsAdmin) {
            //                isAdmin = true
            //            }
            let parameterStr = "password=\(txtPasswordVoter.text!)&email=\(txtUserNameVoter.text!)&token_passkey=\(self.txtTokenPassVoter.text!)&imei_number=\(UIDevice.current.identifierForVendor!.uuidString)&is_admin=\(isAdmin)"
            ActivityController().showActivityIndicator(uiView: self.view)
            ApiService().callApiPost(strAction: WebServiceConstans.VoterLoginVote, strWebType: "POST", paramsString: parameterStr) { (resp) in
                ActivityController().hideActivityIndicator(uiView: self.view)
                let response = (resp as! [String: AnyObject])["response"] as! [String: AnyObject]
                let status = response["status"] as! Bool
                if status == true {
                    UserDefaults.standard.set(response[WebServiceConstans.kVoterAccountNumber], forKey: WebServiceConstans.kVoterAccountNumber)
                    self.isLoggedIn = true
                    self.baseLoginView.isHidden = true
                    self.fetchBallotLikeContent()
                }
            }
        }
    }
    
    @IBAction func btnLoginAdminAction(_ sender: Any) {
        if self.areAdminDataValid() {
            let parameterStr = "password=\(txtPasswordVoter.text!)&email=\(txtUserNameVoter.text!)&token_passkey=\(self.admin!.tokenPasskey!)"
            ApiService().callApiPost(strAction: WebServiceConstans.AdminLoginVote, strWebType: "POST", paramsString: parameterStr) { (resp) in
                let response = (resp as! [String: AnyObject])["response"] as! [String: AnyObject]
                let status = response["status"] as! Bool
                if status == true {
                    self.adminLoginView.isHidden = true
                }
            }
        }
    }
    
    func areAdminDataValid() -> Bool {
        var msg = ""
        if txtAdminUsername.text?.isBlank ?? true {
            msg = "Enter email address of admin"
            showMessage(msg)
            return false
        }else if txtAdminUsername.text?.isEmail ?? false {
        }else {
            msg = "Email address of admin is not valid"
            showMessage(msg)
            return false
        }
        return true
    }
    
    func areVoterDataValid() -> Bool {
        
        var msg = ""
        if txtUserNameVoter.text?.isBlank ?? true {
            msg = "Enter email address of voter"
            showMessage(msg)
            return false
        }else if txtUserNameVoter.text?.isEmail ?? false {
        }else {
            msg = "Email address of voter is not valid"
            showMessage(msg)
            return false
        }
        return true
    }
    
    func showMessage(_ messageString: String) {
        let alert = UIAlertController(title: nil, message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lblBallotLikeTitle: UILabel!
    @IBOutlet weak var webviewContent: UIWebView!
    
    ///VOTE WARE
    @IBAction func btnLogoutAction(_ sender: Any) {
        self.isLoggedIn = false
        self.baseLoginView.isHidden = false
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClickToVoteAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "SecondStoryBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ElectivePositionsViewController") as! ElectivePositionsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    MARK: electionview position controller delegate
    @objc func logoutVoter() {
        self.isLoggedIn = false
        self.baseLoginView.isHidden = false
    }
    
}
