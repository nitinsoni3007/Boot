//
//  EventNScheduleViewController.swift
//  Boot
//
//  Created by Nitin on 20/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EventNScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventCellDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnNow: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var arrEvents = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchTextField = searchBar.value(forKey: "searchField") as! UITextField
        searchTextField.backgroundColor = UIColor.clear
        searchBar.tintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
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
    
    //MARK: search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        //api for searching with search text
    }
    
    //MARK: tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EventCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! EventCell
        cell.configure(withEvent: arrEvents[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        controller.selectedEvent = arrEvents[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: event cell delegate
    func showMapForLatLong(lat: String, Long: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        controller.latitude = lat
        controller.longitude = Long
        navigationController?.pushViewController(controller, animated: true)
    }

}
