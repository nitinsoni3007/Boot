//
//  ElectivePositionCell.swift
//  Boot
//
//  Created by Nitin on 06/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

protocol ElectivePositionCellDelegate {
    func selectedElectivePostion(_ electivePos: ElectivePosition)
}

class ElectivePositionCell: UITableViewCell {

    @IBOutlet weak var imgElePos: UIImageView!
    @IBOutlet weak var lblTitleElPos: UILabel!
    @IBOutlet weak var btnEndDateElPos: UIButton!
    var delegate: ElectivePositionCellDelegate?
    var currentElePos: ElectivePosition!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithElectivePosition(_ electPos: ElectivePosition) {
        currentElePos = electPos
        imgElePos.imageFromServerURL(urlString: electPos.electionPicUrl!, andStore: true)
        lblTitleElPos.text = electPos.electionName
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let endDate = df.date(from: electPos.endDate!)!
        if endDate.compare(Date()) == ComparisonResult.orderedAscending{
            btnEndDateElPos.backgroundColor = UIColor.red
            btnEndDateElPos.isEnabled = false
        }
        btnEndDateElPos.setTitle(electPos.endDate, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnEndDateElPosAction(_ sender: Any) {
        self.delegate?.selectedElectivePostion(currentElePos)
    }
}
