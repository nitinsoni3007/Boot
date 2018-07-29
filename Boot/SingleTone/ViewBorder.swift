//
//  ViewBorder.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class ViewBorder: NSObject {
    
    static let  shareViewBorder =  ViewBorder()
    var arrTitle = [Title]()
    var arrState = [State]()
    var arrVolunteerFields = [VolunteerField]()
    var arrGender = [String]()
    var arrAge = [String]()
    
    private  override init() {
        
        arrGender.append("Male")
        arrGender.append("Female")
        
        arrAge.append("17-24")
        arrAge.append("25-34")
        arrAge.append("35-44")
        arrAge.append("45-54")
        arrAge.append("55-64")
        arrAge.append("65+")
    }
    
    func borderView(objView:UIView, objcolor:UIColor)
    {
        objView.layer.cornerRadius =  5.0
        objView.layer.borderWidth =  2.0
        objView.layer.borderColor =  objcolor.cgColor
    }
    
    func stringFromHTML(strHtml:String) -> String
    {
        let str = strHtml.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return str
    }
    
    func  shareText(strShare: String,objview:UIViewController)
    {
        let text = strShare
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = objview.view
        objview.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func shareVideo(strVideoUrl:String, objViw:UIViewController)
    {
        guard let videoURL = URL(string: strVideoUrl) else { return }
        let activityVC = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = objViw.view
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList,UIActivityType.openInIBooks, UIActivityType.openInIBooks]
        objViw.present(activityVC, animated: true, completion: nil)
    }
    
    func shareImage(imgComman:UIImage, objView:UIViewController)
    {
        let imageShare = [imgComman]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = objView.view
        objView.present(activityViewController, animated: true, completion: nil)
    }
    

}
