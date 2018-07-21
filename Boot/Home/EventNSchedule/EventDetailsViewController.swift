//
//  EventDetailsViewController.swift
//  Boot
//
//  Created by Nitin on 21/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

private enum InfoType {
    case about_us
    case speakers
    case notes
}

class EventDetailsViewController: UIViewController {

    
    
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
    
    @IBOutlet weak var lblDiscription: UILabel!
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
        viewAbout.isHidden = true
        viewSpeakers.isHidden = true
        viewNotes.isHidden = true
        btnAboutUs.setTitleColor(UIColor.black, for: .normal)
        btnSpeakers.setTitleColor(UIColor.black, for: .normal)
        btnNotes.setTitleColor(UIColor.black, for: .normal)
        var centerXToMove = underline.center.x
        switch type {
        case .about_us:
            viewAbout.isHidden = false
            centerXToMove = btnAboutUs.center.x
            btnAboutUs.setTitleColor(UIColor.red, for: .normal)
        case .speakers:
            viewSpeakers.isHidden = false
            centerXToMove = btnSpeakers.center.x
            btnSpeakers.setTitleColor(UIColor.red, for: .normal)
        case .notes:
            viewNotes.isHidden = false
            centerXToMove = btnNotes.center.x
            btnNotes.setTitleColor(UIColor.red, for: .normal)
        }
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
    
}
