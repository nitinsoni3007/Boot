//
//  LaunchViewController.swift
//  BOOT
//
//  Created by snehil on 14/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
 var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService().callApi(strAction: WebServiceConstans.VolunteerField, strWebType: "GET", params: [:], complition: { (dict) in
            
            let dictSate:NSMutableDictionary =  dict as! NSMutableDictionary
            let arrSate = dictSate.object(forKey: "volunteerfield_data") as! NSArray
            for(_,dict) in  arrSate.enumerated()
            {
                let dictVolunteerField:NSMutableDictionary = dict as! NSMutableDictionary
                let objVolunteerField = VolunteerField()
                objVolunteerField.vfieldname = dictVolunteerField.object(forKey: "vfieldname") as! String
                ViewBorder.shareViewBorder.arrVolunteerFields.append(objVolunteerField)
                
            }
            
        })
        
        ApiService().callApi(strAction:WebServiceConstans.Title , strWebType: "GET", params: [:]) { (dict) in
            let dictTitle:NSMutableDictionary = dict as! NSMutableDictionary
            let arrTitle = dictTitle.object(forKey: "title_data") as! NSArray
            for (_,dict) in arrTitle.enumerated()
            {
                let dictTemp:NSMutableDictionary = dict as! NSMutableDictionary
                let objTitle = Title()
                objTitle.titlename = dictTemp.object(forKey: "titlename") as! String
                ViewBorder.shareViewBorder.arrTitle.append(objTitle)
            }
            
        }
        
            ApiService().callApi(strAction: WebServiceConstans.State, strWebType: "GET", params: [:], complition: { (dict) in
                
                let dictSate:NSMutableDictionary =  dict as! NSMutableDictionary
                let arrSate = dictSate.object(forKey: "ngstates_data") as! NSArray
                for(_,dict) in  arrSate.enumerated()
                {
                    let dictState:NSMutableDictionary = dict as! NSMutableDictionary
                    let objState = State()
                    objState.id = dictState.object(forKey: "id") as! String
                    objState.state = dictState.object(forKey: "state") as! String
                    objState.StateCode = dictState.object(forKey: "StateCode") as! String
                    ViewBorder.shareViewBorder.arrState.append(objState)
                    
                }
                
            })
            
        
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            let nav:UINavigationController =  UINavigationController.init(rootViewController: initialViewController)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
