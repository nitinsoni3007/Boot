//
//  BootTamTableCell.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class BootTamTableCell: UITableViewCell {

    @IBOutlet var imgProfile:UIImageView!
    @IBOutlet var lblFirstName:UILabel!
    @IBOutlet var lblOssition:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
