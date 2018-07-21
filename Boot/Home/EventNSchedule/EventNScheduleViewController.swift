//
//  EventNScheduleViewController.swift
//  Boot
//
//  Created by Nitin on 20/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EventNScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnNow: UIButton!
    @IBOutlet weak var tblView: UITableView!
    var arrEvents = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchEvents()
    }
    
    func fetchEvents() {
        ApiService().callApi(strAction: "event", strWebType: "GET", params: [String: String]()) { (result) in
            if result is [String:AnyObject] {
                let resultDict = result as! [String:AnyObject]
                let arrEventDicts = resultDict["event_data"] as! [[String: AnyObject]]
                self.arrEvents = arrEventDicts.map({Event.init(object: $0)})
                self.tblView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAllAction(_ sender: Any) {
    }
    
    @IBAction func btnNowAction(_ sender: Any) {
    }
    
    //MARK: tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EventCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! EventCell
        cell.configure(withEvent: arrEvents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }

}
