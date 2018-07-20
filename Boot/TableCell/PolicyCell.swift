//
//  PolicyCell.swift
//  BOOT
//
//  Created by Manish Pathak on 11/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//


protocol PolicyCellDelegate {
    
    func getIndexOfShareBtn(currentIndex:Int)
}


import UIKit


class PolicyCell: UITableViewCell {
    
    
   @IBOutlet var lblTitle:UILabel!
   @IBOutlet var txtDes:UITextView!
    @IBOutlet var btnShare:UIButton!
    var delegate:PolicyCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnShare(_sender:UIButton)
    {
     delegate.getIndexOfShareBtn(currentIndex: _sender.tag)
    }

}
