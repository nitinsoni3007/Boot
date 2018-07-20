//
//  VideoCell.swift
//  BOOT
//
//  Created by snehil on 07/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

protocol VideoCellDelegate{
    
    func getCurrentBtnIndex(currentIndex:Int)
}


import UIKit


class VideoCell: UITableViewCell {
    
    
    var delegate:VideoCellDelegate!
    @IBOutlet var btnShareVideo:UIButton!
    
    @IBOutlet var imgThumb:UIImageView!
    @IBOutlet var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnShareVideo(_sender: UIButton)
    {
        delegate.getCurrentBtnIndex(currentIndex: _sender.tag)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
