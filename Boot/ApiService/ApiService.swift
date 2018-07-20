//
//  ApiService.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    func callApi(strAction:String,strWebType:String,params: Dictionary<String, String>, complition:@escaping (Any)->())
    {
       
        print(params)
        let request = NSMutableURLRequest(url: NSURL(string: webServiceActions.BaseUrl + strAction)! as URL)
        let session = URLSession.shared
        if strWebType == "POST"
        {
            request.httpMethod = "POST"
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            do {
                let json = try JSONSerialization.data(withJSONObject: params, options: [])
                request.httpBody = json
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        else{
            request.httpMethod = "GET"
        }
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                complition("error")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                print(json)
                DispatchQueue.main.async(execute: {
                    complition(json)
                })
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        
        task.resume()
    }
    
    
    func callApiPost(strAction:String,strWebType:String,paramsString: String, complition:@escaping (Any)->())
    {
        
        let request = NSMutableURLRequest(url: NSURL(string: webServiceActions.BaseUrl + strAction)! as URL)
        let session = URLSession.shared
       
            request.httpMethod = "POST"
          //let postString = "a=\(usernametext.text!)&b=\(password.text!)&c=\(info.text!)&d=\(number.text!)"
          // let postString = "statename=\("ADAMAWA")"
           request.httpBody = paramsString.data(using: String.Encoding.utf8)
        
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
            

        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                complition("error")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                print(json)
                DispatchQueue.main.async(execute: {
                    complition(json)
                })
            }
            catch let jsonError{
                print(jsonError)
            }
        }
        
        task.resume()
    }
    
    
    //MARK Get Scroll Images for home Pages and Bottom scroll Images
    
    func getApplicationParam(strAction:String,strwbType:String, dict:NSMutableDictionary, complition:@escaping(_ dict: NSMutableDictionary) -> ())
    {
        self.callApi(strAction: strAction, strWebType: strwbType, params: dict as! Dictionary<String,String>) { (dict) in
            
            complition(dict as! NSMutableDictionary)
        }
    }
    
    //Get Policy Data
    func getPolicyData(strAction:String,strwbType:String, dict:NSMutableDictionary, complition:@escaping(_ dict: NSMutableDictionary) -> ())
    {
        self.callApi(strAction: strAction, strWebType: strwbType, params: dict as! Dictionary<String, String>) { (dict) in
         
            complition(dict as! NSMutableDictionary)
        }
    }
    
    //Get BootTeamRecored
    
    func getBootTeamRecored(strAction:String,strwbType:String, dict:NSMutableDictionary, complition:@escaping(_ dict: NSMutableDictionary) -> ())
    {
        self.callApi(strAction: strAction, strWebType: strwbType, params: dict as! Dictionary<String, String>) { (dict) in
            
            complition(dict as! NSMutableDictionary)
        }
    }
    
    //Get Video List
    

  
}
