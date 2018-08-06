//
//  EBallotCell.swift
//  Boot
//
//  Created by Nitin on 06/08/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EBallotCell: UITableViewCell {

    @IBOutlet weak var imgCandidate: UIImageView!
    @IBOutlet weak var lblCandidateName: UILabel!
    @IBOutlet weak var lblCandidateDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithCandidate(_ candidate: Candidate) {
        imgCandidate.imageFromServerURL(urlString: candidate.candidatePicUrl!, andStore: true)
        lblCandidateName.text = candidate.candidatename
        lblCandidateDesc.text = candidate.electionposition
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
