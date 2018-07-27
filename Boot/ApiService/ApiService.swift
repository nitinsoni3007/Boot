//
//  ApiService.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit
import MobileCoreServices

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
                let respStr = String.init(data: data!, encoding: .utf8)
                print("\(respStr)")
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
    
    func callMultiPartAPI(strAction:String,strWebType:String,params: [String:String], filePath: String,complition:@escaping (Any)->()) {
        do {
            let request = try createRequest(actionStr: webServiceActions.BaseUrl + strAction, params: params, filePath: filePath)
            let session = URLSession.shared
            
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
        }catch {
            print("erro while creating multipart request")
        }
    }
    
    func createRequest(actionStr: String, params: [String:String], filePath: String) throws -> URLRequest {
        let parameters = params  // build your dictionary however appropriate
        
        let boundary = generateBoundaryString()
        
        let url = URL(string: actionStr)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let path1 = filePath
        //, "volunteer_file": documentUrl?.lastPathComponent ?? "testFile"
        request.httpBody = try createBody(with: parameters, filePathKey: "volunteer_file", paths: [path1], boundary: boundary)
        print("request desc = \(request.debugDescription)")
        return request
    }
    private func createBody(with parameters: [String: String]?, filePathKey: String, paths: [String], boundary: String) throws -> Data {
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        for path in paths {
            let url = URL(string: path)
            let filename = url?.lastPathComponent ?? "default"
            do {
                let data = try Data(contentsOf: url!)
            let mimetype = mimeType(for: path)

            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")//
            body.append("Content-Type: \(mimetype)\r\n\r\n")//
            body.append(data)
            body.append("\r\n")
            }catch {
//
            }
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
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
