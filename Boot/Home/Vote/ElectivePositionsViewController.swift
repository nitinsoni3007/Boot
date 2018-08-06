//
//  ElectivePositionsViewController.swift
//  Boot
//
//  Created by Nitin on 06/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class ElectivePositionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ElectivePositionCellDelegate {

    @IBOutlet weak var tblView: UITableView!
    var arrElectivePositions = [ElectivePosition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchElectivePositions()
        // Do any additional setup after loading the view.
    }
    
    func fetchElectivePositions() {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApi(strAction: WebServiceConstans.BallotGpPositions, strWebType: "GET", params: [String:String]()) { (resp) in
            ActivityController().hideActivityIndicator(uiView: self.view)
            if let respDicts = (resp as! [String: AnyObject])["response"] as? [[String: String]] {
                self.arrElectivePositions = respDicts.map({ElectivePosition(object: $0)})
                self.tblView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WebServiceConstans.kNotificationLogVoterOut), object: nil, userInfo: nil)
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: tableview delegate, datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrElectivePositions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ElectivePositionCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ElectivePositionCell
        cell.delegate = self
        cell.configureWithElectivePosition(arrElectivePositions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    //MARK: electionposition cell delegate
    func selectedElectivePostion(_ electivePos: ElectivePosition) {
        checkIfAlreadyCastedVoteThenVote(electivePos)
    }
    
    func checkIfAlreadyCastedVoteThenVote(_ electPos: ElectivePosition){
        let paramsString = "electionno=\(electPos.electionCode)&account_no=\(UserDefaults.standard.value(forKey: WebServiceConstans.kVoterAccountNumber))"
        ApiService().callApiPost(strAction: WebServiceConstans.CheckVote, strWebType: "POST", paramsString: paramsString) { (resp) in
            if let respDict = (resp as? [String: AnyObject] ?? [String: AnyObject]())["response"] as? [String: AnyObject] {
                if respDict["status"] as! Bool == true {
                    if respDict["is_voted"] as! Bool == false {
                        let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "EBallotPaperViewController") as! EBallotPaperViewController
                        controller.selectedElectPos = electPos
                        self.navigationController?.pushViewController(controller, animated: true)
                    }else {
                        
                        let alert = UIAlertController(title: nil, message: "Already casted vote for this election", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
        }
    }

}
