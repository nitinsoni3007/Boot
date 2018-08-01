//
//  FAQViewController.swift
//  Boot
//
//  Created by Nitin on 01/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    var arrFAQs = [FAQ]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFAQs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchFAQs() {
        ApiService().callApi(strAction: WebServiceConstans.FAQs, strWebType: "GET", params: [String:String]()) { (resp) in
            let faqsDicts = resp as? [[String: AnyObject]] ?? [[String: AnyObject]]()
            self.arrFAQs = faqsDicts.map({FAQ.init(object: $0)})
            self.tblView.reloadData()
        }
    }

    
    //MARK: tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFAQs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "FAQCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        let lblTitle = cell?.contentView.viewWithTag(101) as! UILabel
        lblTitle.text = arrFAQs[indexPath.row].question
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let faq = arrFAQs[indexPath.row]
        let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "FAQDetailsViewController") as! FAQDetailsViewController
        detailVC.faq = faq
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    

}
