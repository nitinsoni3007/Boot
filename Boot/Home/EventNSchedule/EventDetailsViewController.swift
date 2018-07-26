//
//  EventDetailsViewController.swift
//  Boot
//
//  Created by Nitin on 21/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

private enum InfoType: Int {
    case about_us = 0
    case speakers = 1
    case notes = 2
}

class EventDetailsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAttend: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnAboutUs: UIButton!
    @IBOutlet weak var btnSpeakers: UIButton!
    @IBOutlet weak var btnNotes: UIButton!
    var selectedEvent: Event?
    
    @IBOutlet weak var svDetails: UIScrollView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblSpeakers: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var viewNotes: UIView!
    @IBOutlet weak var viewSpeakers: UIView!
    @IBOutlet weak var viewAbout: UIView!
    var underline: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAttend.layer.borderWidth = 2
        containerView.layer.borderWidth = 2
        addUnderlineToOptions()
        resetContainer(type: .about_us)
    }
    
    func addUnderlineToOptions() {
        underline = UIView(frame: CGRect(x: 0, y: btnAboutUs.bounds.height, width: btnAboutUs.bounds.width, height: 2))
        underline.backgroundColor = UIColor.red
        btnAboutUs.superview?.addSubview(underline)
    }
    
    fileprivate func resetContainer(type: InfoType) {
//        viewAbout.isHidden = true
//        viewSpeakers.isHidden = true
//        viewNotes.isHidden = true
        btnAboutUs.setTitleColor(UIColor.black, for: .normal)
        btnSpeakers.setTitleColor(UIColor.black, for: .normal)
        btnNotes.setTitleColor(UIColor.black, for: .normal)
        var centerXToMove = underline.center.x
        switch type {
        case .about_us:
            centerXToMove = btnAboutUs.center.x
            btnAboutUs.setTitleColor(UIColor.red, for: .normal)
        case .speakers:
            centerXToMove = btnSpeakers.center.x
            btnSpeakers.setTitleColor(UIColor.red, for: .normal)
        case .notes:
            centerXToMove = btnNotes.center.x
            btnNotes.setTitleColor(UIColor.red, for: .normal)
        }
        svDetails.setContentOffset(CGPoint(x: CGFloat(type.rawValue) * svDetails.bounds.width, y: 0), animated: true)
        let newCenterOfUnderline = CGPoint(x: centerXToMove, y: underline.center.y)
        UIView.animate(withDuration: 0.3) {
            self.underline.center = newCenterOfUnderline
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblEventTitle.text = selectedEvent!.title
        lblStartTime.text = "Start :" + (selectedEvent?.starttime ?? "")
        lblEndTime.text = "End :" + (selectedEvent?.endtime ?? "")
        lblAddress.text = selectedEvent!.location ?? ""
        lblDiscription.text = selectedEvent?.descriptionValue ?? ""
        lblSpeakers.text = selectedEvent?.speakersName ?? ""
        lblNotes.text = "Please login to get your event pass."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        svDetails.contentSize = CGSize(width: svDetails.bounds.width * 3, height: svDetails.bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAttendAction(_ sender: Any) {
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
        var textToShare = selectedEvent?.title ?? "" + "\n"
        textToShare.append("Start :" + (selectedEvent?.starttime ?? "") + "\n")
        textToShare.append("End :" + (selectedEvent?.endtime ?? "") + "\n")
        textToShare.append("Venue :" + (selectedEvent?.location ?? ""))
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender as! UIButton
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func btnAboutAction(_ sender: Any) {
        resetContainer(type: .about_us)
    }
    
    @IBAction func btnSpeakerAction(_ sender: Any) {
        resetContainer(type: .speakers)
    }
    
    @IBAction func btnNotesAction(_ sender: Any) {
        resetContainer(type: .notes)
    }
    
    //MARK: uiscrollview delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageInd = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        if pageInd < 3 {
            resetContainer(type: InfoType(rawValue:pageInd)!)
        }
    }
    
}
