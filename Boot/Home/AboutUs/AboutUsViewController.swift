//
//  AboutUsViewController.swift
//  Boot
//
//  Created by Nitin on 30/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var btnOurPhilosophy: UIButton!
    @IBOutlet weak var btnWhoWeAre: UIButton!
    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var tblWhoWeAre: UITableView!
    @IBOutlet weak var tblPhilosophy: UITableView!
    var arrData = [AnyObject]()
    var arrIntro = [Intro]()
    var arrPhilosophy = [Philosophy]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var underlineFrame = underlineView.frame
        underlineFrame.size.width = view.bounds.width/2
        tblWhoWeAre.rowHeight = UITableViewAutomaticDimension
        tblWhoWeAre.estimatedRowHeight = 500.00
        tblPhilosophy.rowHeight = UITableViewAutomaticDimension
        tblPhilosophy.estimatedRowHeight = 500.00
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        svMain.contentSize = CGSize(width: svMain.bounds.width * 2, height: svMain.bounds.height)
        fetchIntroNPhilosophy()
        
    }
    
    func fetchIntroNPhilosophy() {
        ApiService().callApi(strAction: "applicationparameters/aboutus", strWebType: "GET", params: [String: String]()) { (resp) in
            let arrIntroDicts = (resp as! [String: AnyObject])["aboutus"] as? [[String: String]] ?? [[String: String]]()
            self.arrIntro = arrIntroDicts.map({Intro(object: $0)}) as! [Intro]
            let arrPhilosophyDicts = (resp as! [String: AnyObject])["aboutus_philosophy"] as? [[String: String]] ?? [[String: String]]()
            self.arrPhilosophy = arrPhilosophyDicts.map({Philosophy(object: $0)}) as! [Philosophy]
            self.tblWhoWeAre.reloadData()
            self.tblPhilosophy.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnWhoWeAreAction(_ sender: Any) {
        btnWhoWeAre.setTitleColor(UIColor.red, for: .normal)
        btnOurPhilosophy.setTitleColor(UIColor.black, for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.underlineView.center = CGPoint(x: self.btnWhoWeAre.center.x, y: self.underlineView.center.y)
        }
        svMain.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func btnOurPhilosophyAction(_ sender: Any) {
        btnWhoWeAre.setTitleColor(UIColor.black, for: .normal)
        btnOurPhilosophy.setTitleColor(UIColor.red, for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.underlineView.center = CGPoint(x: self.btnOurPhilosophy.center.x, y: self.underlineView.center.y)
        }
        svMain.setContentOffset(CGPoint(x: svMain.bounds.width, y: 0), animated: true)
    }
    
    //MARK: tableview delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblWhoWeAre {
            return arrIntro.count
        }else {
            return arrPhilosophy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblWhoWeAre {
            let intro = arrIntro[indexPath.row]
            let cellId = "IntroCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            let lblTitle = cell?.contentView.viewWithTag(101) as! UILabel
            lblTitle.text = intro.title
            let textView = cell?.contentView.viewWithTag(102) as! UITextView
            textView.text = ViewBorder.shareViewBorder.stringFromHTML(strHtml: intro.descriptionValue!)
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            return cell!
        }else {
            let philosophy = arrPhilosophy[indexPath.row]
            let cellId = "PhilosophyCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            let lblTitle = cell?.contentView.viewWithTag(201) as! UILabel
            lblTitle.text = philosophy.title
            let textView = cell?.contentView.viewWithTag(202) as! UITextView
            textView.text = ViewBorder.shareViewBorder.stringFromHTML(strHtml: philosophy.descriptionValue!)
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == svMain {
        if scrollView.contentOffset.x == 0 {
            btnWhoWeAre.setTitleColor(UIColor.red, for: .normal)
            btnOurPhilosophy.setTitleColor(UIColor.black, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.underlineView.center = CGPoint(x: self.btnWhoWeAre.center.x, y: self.underlineView.center.y)
            }
        }else if scrollView.contentOffset.x >= svMain.bounds.width{
            btnWhoWeAre.setTitleColor(UIColor.black, for: .normal)
            btnOurPhilosophy.setTitleColor(UIColor.red, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.underlineView.center = CGPoint(x: self.btnOurPhilosophy.center.x, y: self.underlineView.center.y)
            }
        }
        }
    }
    
}
