//
//  OnlinToolDetailViewController.swift
//  Boot
//
//  Created by Nitin on 30/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class OnlinToolDetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var lblTitle: UILabel!
    var onlineTool: OnlineTool!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblTitle.text = onlineTool.title ?? "Detail"
        let urlReq = URLRequest(url: URL(string: onlineTool.url!)!)
        ActivityController().showActivityIndicator(uiView: webview)
        webview.loadRequest(urlReq)
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
        ActivityController().hideActivityIndicator(uiView: webView)
    }

}
