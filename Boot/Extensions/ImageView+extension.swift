//
//  ImageView+extension.swift
//  Boot
//
//  Created by Nitin on 06/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import Foundation
import UIKit

var ddPath : String {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
}

extension UIImageView {
    public func imageFromServerURL(urlString: String, andStore store: Bool) {
        if let img = getImage(withName: urlString) {
            self.image = img
        }else {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                if store {
                    self.storImage(withName: urlString, imgData: data!)
                }
            })
            
        }).resume()
        }
    }
    
    func storImage(withName name: String, imgData: Data) {
        let filePath = ddPath + "/" + (name.components(separatedBy: "/").last ?? "test.png")
        if FileManager.default.fileExists(atPath: filePath) == false {
            do {
                try imgData.write(to: URL(fileURLWithPath: filePath))
            }catch {
                print("unable to write in file")
            }
        }
    }
    
    func getImage(withName name: String) -> UIImage?{
        let filePath = ddPath + "/" + (name.components(separatedBy: "/").last ?? "test.png")
        if FileManager.default.fileExists(atPath: filePath) {
            let imgData = FileManager.default.contents(atPath: filePath)!
            return UIImage(data: imgData)!
        }
        return nil
    }
}

