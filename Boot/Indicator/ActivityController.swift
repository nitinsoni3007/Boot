//
//  ActivityController.swift
//  BOOT
//
//  Created by Manish Pathak on 19/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

import  Foundation

class ActivityController {
    
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    func showActivityIndicator(uiView: UIView) {
        
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.tag =  100
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        let  loadingView: UIView = UIView()
        // loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        // actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        //  actInd.center = CGPointMake(loadingView.frame.size.width / 2,
        // loadingView.frame.size.height / 2);
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func hideActivityIndicator(uiView: UIView) {
        
        DispatchQueue.main.async {
            
            //            self.activityIndicator.stopAnimating()
            //            self.activityIndicator.removeFromSuperview()
            //            self.container.removeFromSuperview()
            //            self.loadingView.removeFromSuperview()
            
            if let viewWithTag = uiView.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }else{
                print("No!")
            }
            
            
        }
    }

}
