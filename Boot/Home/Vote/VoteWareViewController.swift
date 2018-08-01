//
//  VoteWareViewController.swift
//  Boot
//
//  Created by Nitin on 31/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class VoteWareViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtTokenPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 6.0
        btnLogin.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
    }
    
}
