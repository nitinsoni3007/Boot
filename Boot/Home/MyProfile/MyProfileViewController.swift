//
//  MyProfileViewController.swift
//  Boot
//
//  Created by Nitin on 03/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var lblAccNumber: UILabel!
    @IBOutlet weak var lblTokenPassKey: UILabel!
    
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtPrefFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnLocalGovt: UIButton!
    @IBOutlet weak var btnWard: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtPassward: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    var loginVC : LoginViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.value(forKey: WebServiceConstans.kAccountNumber){
            addLoginView()
        }
        
    }
    
    func addLoginView() {
        let sb = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        loginVC = (sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        self.addChildViewController(loginVC!)
        loginVC!.view.backgroundColor = UIColor.clear
        loginVC!.view.frame = CGRect(x: 0, y: 70, width: self.view.bounds.width, height: self.view.bounds.height - 70)
        self.view.addSubview(loginVC!.view)
        loginVC!.didMove(toParentViewController: self)
    }
    
    func hideLoginView() {
        loginVC!.view.removeFromSuperview()
        loginVC!.removeFromParentViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        svMain.contentSize = CGSize(width: svMain.bounds.width, height: 1910)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRevealTokenPasskeyAction(_ sender: Any) {
    }
    
    @IBAction func btnGenderAction(_ sender: Any) {
    }
    
    @IBAction func btnTitleAction(_ sender: Any) {
    }
    
    @IBAction func btnStateAction(_ sender: Any) {
    }
    
    @IBAction func btnLocalGovAction(_ sender: Any) {
    }
    
    @IBAction func btnWardAction(_ sender: Any) {
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
    }
    
    
    
}
