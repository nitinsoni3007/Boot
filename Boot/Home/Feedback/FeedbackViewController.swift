//
//  FeedbackViewController.swift
//  Boot
//
//  Created by Nitin on 03/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var btnFeedBack: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var tvFeedback: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnUploadFile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtName.layer.borderColor = 2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendAction(_ sender: Any) {
    }
    @IBAction func btnUploadFileAction(_ sender: Any) {
    }
    
    @IBAction func btnFeedbackAction(_ sender: Any) {
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
    }
    
}
