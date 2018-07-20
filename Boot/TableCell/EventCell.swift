//
//  EventCell.swift
//  Boot
//
//  Created by Nitin on 21/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet var lblEventName:UILabel!
    @IBOutlet var lblStartAt:UILabel!
    @IBOutlet var lblEndAt:UILabel!
    @IBOutlet var lblAddress:UILabel!
    @IBOutlet var lblAttandanceType:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withEvent event: Event) {
        
    }
    
    @IBAction func btnMapItAction(_ sender: UIButton) {
        
    }

}
