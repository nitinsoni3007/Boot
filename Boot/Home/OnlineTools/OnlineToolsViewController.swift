//
//  OnlineToolsViewController.swift
//  Boot
//
//  Created by Nitin on 30/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class OnlineToolsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    var onlineTools = [OnlineTool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchOnlineTools()
    }
    
    func fetchOnlineTools() {
        ApiService().callApi(strAction: WebServiceConstans.OnlineTools, strWebType: "GET", params: [String:String]()) { (resp) in
            let respOnlineTool = resp as! [String: AnyObject]
            let onlineToolsDicts = respOnlineTool["online_tool"] as? [[String: String]] ?? [[String: String]]()
            self.onlineTools = onlineToolsDicts.map({OnlineTool(object: $0)})
            self.tblView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineTools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "OnlineToolCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        let lblTitle = cell?.contentView.viewWithTag(101) as! UILabel
//        lblTitle.textColor = "#800000".colorFromHeX()
        lblTitle.text = onlineTools[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let onlineTool = onlineTools[indexPath.row]
        let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "OnlinToolDetailViewController") as! OnlinToolDetailViewController
        detailVC.onlineTool = onlineTool
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
