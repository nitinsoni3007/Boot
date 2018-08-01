//
//  HelpDeskViewController.swift
//  Boot
//
//  Created by Nitin on 30/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class HelpDeskViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var underline: UIView!
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var btnTechnical: UIButton!
    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var txtNameEv: UITextField!
    @IBOutlet weak var txtEmailEv: UITextField!
    @IBOutlet weak var txtPhoneEv: UITextField!
    @IBOutlet weak var tvDescEv: UITextView!
    @IBOutlet weak var btnSubmitEv: UIButton!
    @IBOutlet weak var txtNameT: UITextField!
    @IBOutlet weak var txtEmailT: UITextField!
    @IBOutlet weak var txtPhoneT: UITextField!
    @IBOutlet weak var tvDescT: UITextView!
    @IBOutlet weak var btnSubmitT: UIButton!
    @IBOutlet weak var lblDescEv: UILabel!
    @IBOutlet weak var lblDescT: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderToSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        svMain.contentSize = CGSize(width: svMain.bounds.width * 2, height: svMain.bounds.height)
    }
    
    func setBorderToSubviews() {
        let forms = svMain.subviews
        for form in forms {
            for subView in form.subviews {
                if subView is UILabel{
                    continue
                }
                subView.layer.borderWidth = 2.0
                subView.layer.borderColor = UIColor.black.cgColor
                subView.layer.cornerRadius = 6.0
                subView.clipsToBounds = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEventAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.underline.center = CGPoint(x: self.btnEvent.center.x, y: self.underline.center.y)
        }
        self.btnEvent.setTitleColor(UIColor.red, for: .normal)
        self.btnTechnical.setTitleColor(UIColor.black, for: .normal)
        svMain.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func btnTechnicalAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.underline.center = CGPoint(x: self.btnTechnical.center.x, y: self.underline.center.y)
        }
        self.btnEvent.setTitleColor(UIColor.black, for: .normal)
        self.btnTechnical.setTitleColor(UIColor.red, for: .normal)
        svMain.setContentOffset(CGPoint(x: svMain.bounds.width, y: 0), animated: true)
    }
    
    @IBAction func btnSubmitEvAction(_ sender: Any) {   
    }
    
    @IBAction func btnSubmitTAction(_ sender: Any) {
    }
    
    //MARK: textview delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        var offsetX = CGFloat(0)
        if textView == tvDescEv {
            lblDescEv.isHidden = true
        }else if textView == tvDescT {
            lblDescT.isHidden = true
            offsetX = svMain.bounds.width
        }
            svMain.setContentOffset(CGPoint(x: offsetX, y: textView.frame.origin.y - 20), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            if textView == tvDescEv {
                lblDescEv.isHidden = false
            }else if textView == tvDescT {
                lblDescT.isHidden = false
            }
            svMain.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    //MARK: scrollview delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if svMain.contentOffset.x == 0 {
            self.view.endEditing(true)
            svMain.contentOffset = CGPoint(x: 0, y: 0)
            UIView.animate(withDuration: 0.3) {
                self.underline.center = CGPoint(x: self.btnEvent.center.x, y: self.underline.center.y)
            }
            self.btnEvent.setTitleColor(UIColor.red, for: .normal)
            self.btnTechnical.setTitleColor(UIColor.black, for: .normal)
        }else if svMain.contentOffset.x == svMain.bounds.width {
            self.view.endEditing(true)
            svMain.contentOffset = CGPoint(x: svMain.bounds.width, y: 0)
            UIView.animate(withDuration: 0.3) {
                self.underline.center = CGPoint(x: self.btnTechnical.center.x, y: self.underline.center.y)
            }
            self.btnEvent.setTitleColor(UIColor.black, for: .normal)
            self.btnTechnical.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
}
