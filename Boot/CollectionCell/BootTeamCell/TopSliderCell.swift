//
//  TopSliderCell.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

protocol  TopSliderCellDelegate {
    
    func getCurrentIndex(currentIndex:Int)
}

import UIKit



class TopSliderCell: UICollectionViewCell {
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var viewBottomLine:UIView!
    @IBOutlet var btnTop:UIButton!
    
    var delegate:TopSliderCellDelegate!
    
    
    @IBAction func btnTopPress(_sender:UIButton)
    {
        delegate.getCurrentIndex(currentIndex: _sender.tag)
    }
    
}
