//
//  EFlyrDetailViewController.swift
//  Boot
//
//  Created by snehil on 28/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EFlyrDetailViewController: UIViewController {

    var strTitle:String!
    var imgProfile:UIImage!
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var imgViewProfile:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgViewProfile.image = self.imgProfile
        self.lblTitle.text = self.strTitle
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIButton Actions
    @IBAction func btnAllActions(sender:UIButton)
    {
        if sender.tag == 1
        {
            
        }
        else if sender.tag == 2
        {
            UIImageWriteToSavedPhotosAlbum(imgProfile, nil, nil, nil);
        }
        else if sender.tag ==  3
        {
           ViewBorder.shareViewBorder.shareImage(imgComman: imgProfile, objView: self)
        }
    }
    
    @IBAction func btnBack(sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
