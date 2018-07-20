//
//  BootDetailScrollTopCell.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

protocol BootDetailScrollTopCellDelegate {
    
    func getCurrentIndex(current:Int)
}

import UIKit

class BootDetailScrollTopCell: UICollectionViewCell {
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var viewBottomLine:UIView!
    @IBOutlet var btnTop:UIButton!
    var delegate:BootDetailScrollTopCellDelegate!
    
    
    @IBAction func btnTopPress(sender:UIButton)
    {
        delegate.getCurrentIndex(current: sender.tag)
    }
    
}
