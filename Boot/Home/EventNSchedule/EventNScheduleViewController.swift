//
//  EventNScheduleViewController.swift
//  Boot
//
//  Created by Nitin on 20/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EventNScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventCellDelegate, UISearchBarDelegate, UITextFieldDelegate {
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnNow: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtDate: UITextField!
    var datepicker: UIDatePicker?
    
    var toShowAllEvents = true
    
    var arrEvents = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchTextField = searchBar.value(forKey: "searchField") as! UITextField
        searchTextField.backgroundColor = UIColor.clear
//        searchBar.tintColor = UIColor.clear
//        searchBar.backgroundColor = UIColor.clear
//        let df = DateFormatter()
//        df.dateFormat = "yyyy"
//        let monthString = df.string(from: Date())
//        txtDate.text = monthString
        fetchEvents(withDate: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func fetchEvents(withDate dateStr:String?) {
        ActivityController().showActivityIndicator(uiView: self.view)
        if dateStr == nil {
        ApiService().callApi(strAction: "event", strWebType: "GET", params: [String: String]()) { (result) in
            
            ActivityController().hideActivityIndicator(uiView: self.view)
            if result is [String:AnyObject] {
                let resultDict = result as! [String:AnyObject]
                let arrEventDicts = resultDict["event_data"] as! [[String: AnyObject]]
                self.arrEvents = arrEventDicts.map({Event.init(object: $0)})
                self.tblView.reloadData()
            }
        }
        }else {
            
            ApiService().callApi(strAction: "event/get_list_by_date", strWebType: "GET", params: ["date": dateStr!]) { (result) in
                
                ActivityController().hideActivityIndicator(uiView: self.view)
                if result is [String:AnyObject] {
                    let resultDict = result as! [String:AnyObject]
                    let arrEventDicts = resultDict["event_data"] as! [[String: AnyObject]]
                    self.arrEvents = arrEventDicts.map({Event.init(object: $0)})
                    if self.toShowAllEvents == false {
                        self.tblView.reloadData()
                    }
                    if self.arrEvents.count == 0 {
                        //show toast message no records found
                    }
                }
            }
        }
    }
    
    func fetchEventsWithKeyword(key:String) {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApi(strAction: "event/get_data_by_keyword", strWebType: "GET", params: ["key": key]) { (result) in
            ActivityController().hideActivityIndicator(uiView: self.view)
            if result is [String:AnyObject] {
                let resultDict = result as! [String:AnyObject]
                let arrEventDicts = resultDict["event_data"] as! [[String: AnyObject]]
                self.arrEvents = arrEventDicts.map({Event.init(object: $0)})
                self.tblView.reloadData()
            }
        }
    }
    
    @IBAction func btnSearchAction(_ sender: Any) {
        btnSearch.isHidden = true
        searchBar.isHidden = false
    }
    
    func pickupDate() {
        datepicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 216))
        datepicker?.datePickerMode = .date
        datepicker?.backgroundColor = UIColor.white
        txtDate.inputView = datepicker!
        //toolbar
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.tintColor = UIColor.blue
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        //adding bar buttons
        let btnCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(btnCancelPickerAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(btnDonePickerAction))
        toolbar.setItems([btnCancel, flexibleSpace, btnDone], animated: false)
        txtDate.inputAccessoryView = toolbar
    }
    
    @objc func btnDonePickerAction() {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        txtDate.text = df.string(from: datepicker!.date)
        txtDate.resignFirstResponder()
        fetchEvents(withDate: txtDate.text!)
    }
    
    @objc func btnCancelPickerAction() {
        txtDate.resignFirstResponder()
    }
    
    //MARK: textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickupDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAllAction(_ sender: Any) {
        toShowAllEvents = true
        btnAll.setTitleColor(UIColor.white, for: .normal)
        btnAll.backgroundColor = btnNow.backgroundColor
        btnNow.setTitleColor(UIColor.black, for: .normal)
        btnNow.backgroundColor = UIColor.white
        fetchEvents(withDate: nil)
    }
    
    @IBAction func btnNowAction(_ sender: Any) {
        toShowAllEvents = false
        btnNow.setTitleColor(UIColor.white, for: .normal)
        btnNow.backgroundColor = btnAll.backgroundColor
        btnAll.setTitleColor(UIColor.black, for: .normal)
        btnAll.backgroundColor = UIColor.white
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        fetchEvents(withDate: df.string(from: Date()))
    }
    
    //MARK: search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if searchBar.text?.count ?? 0 > 0 {
        fetchEventsWithKeyword(key: searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.isHidden = true
        btnSearch.isHidden = false
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
