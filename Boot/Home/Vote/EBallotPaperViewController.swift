//
//  EBallotPaperViewController.swift
//  Boot
//
//  Created by Nitin on 06/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EBallotPaperViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tblView: UITableView!
    var arrCandidates = [Candidate]()
    var selectedElectPos : ElectivePosition!
    var selectedCandidate: Candidate?
    
    @IBOutlet weak var confirmationView: UIView!
    @IBOutlet weak var imgSelectedCandidate: UIImageView!
    @IBOutlet weak var lblSelCandidateName: UILabel!
    @IBOutlet weak var lblSelectedCandidatePosition: UILabel!
    @IBOutlet weak var btnConfirmYes: UIButton!
    @IBOutlet weak var btnConfirmNo: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationView.isHidden = true
        fetchCandidates()
        btnConfirmNo.layer.borderColor = UIColor.black.cgColor
        btnConfirmNo.layer.borderWidth = 1.5
        btnConfirmNo.layer.cornerRadius = 3.0
        btnConfirmYes.layer.borderColor = UIColor.black.cgColor
        btnConfirmYes.layer.borderWidth = 1.5
        btnConfirmYes.layer.cornerRadius = 3.0
        
    }
    
    func fetchCandidates() {
        let paramString = "electionno=\(selectedElectPos.electionCode!)"
        ApiService().callApiPost(strAction: WebServiceConstans.CandidateList, strWebType: "POST", paramsString: paramString) { (resp) in
            if let respDict = resp as? [String:AnyObject] {
                let candidateDicts = respDict["candidate_list"] as? [[String: String]] ?? [[String: String]]()
                self.arrCandidates = candidateDicts.map({Candidate(object: $0)})
                self.tblView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: WebServiceConstans.kNotificationLogVoterOut), object: nil, userInfo: nil)
        navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        
    }
    
    func showConfirmationView(_ selCandidate: Candidate) {
        selectedCandidate = selCandidate
        confirmationView.isHidden = false
        imgSelectedCandidate.imageFromServerURL(urlString: selCandidate.candidatePicUrl!, andStore: true)
        lblSelCandidateName.text = selCandidate.candidatename!
        lblSelectedCandidatePosition.text = selCandidate.electionposition!
    }
    
    @IBAction func btnConfirmYesAction(_ sender: Any) {
        confirmationView.isHidden = true
        let address = getWiFiAddress()
        print("addresses = \(address)")
        let paramsString = "Electionno=\(selectedCandidate!.electionno!)&electionname=\(selectedCandidate!.electionname!)&electionposition=\(selectedCandidate!.electionposition!)&candidateno=\(selectedCandidate!.candidateno!)&candidatename=\(selectedCandidate!.candidatename!)&account_no=\(UserDefaults.standard.value(forKey: WebServiceConstans.kVoterAccountNumber)!)&ip_address=\(address ?? "")&imei_number=\(UIDevice.current.identifierForVendor!.uuidString)"
        ApiService().callApiPost(strAction: WebServiceConstans.CastVote, strWebType: "POST", paramsString: paramsString) { (resp) in
            print("resp = \(resp)")
            if let resDict = resp as? [String: AnyObject] {
                if (resDict["status"] as? Bool ?? false) == true {
                    if resDict["is_casted"] as? Bool ?? false {
                        let alert = UIAlertController(title: nil, message: "Do you want to vote for another position?" as? String ?? "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WebServiceConstans.kNotificationLogVoterOut), object: nil, userInfo: nil)
                            self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
//            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
            
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
//            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    @IBAction func btnConfirmNoAction(_ sender: Any) {
        confirmationView.isHidden = true
    }
    
    //MARK: tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCandidates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EBallotCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! EBallotCell
        cell.configureWithCandidate(arrCandidates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCandidate = arrCandidates[indexPath.row]
        showConfirmationView(selectedCandidate)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
