//
//  FAQDetailsViewController.swift
//  Boot
//
//  Created by Nitin on 02/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class FAQDetailsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblPostedOn: UILabel!
    @IBOutlet weak var tvAnswer: UITextView!
    @IBOutlet weak var webView: UIWebView!
    
    var faq : FAQ!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblQuestion.text = faq.question ?? "NA"
        lblPostedOn.text = faq.entrydate ?? "NA"
        ActivityController().showActivityIndicator(uiView: self.view)
        webView.loadHTMLString(faq.answer!, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: webview delegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ActivityController().hideActivityIndicator(uiView: self.view)
    }

}
