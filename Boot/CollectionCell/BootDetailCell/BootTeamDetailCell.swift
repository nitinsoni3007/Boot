//
//  BootTeamDetailCell.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class BootTeamDetailCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
   
    var strDes:String?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell  = tableView.dequeueReusableCell(withIdentifier: "BootDetailTableCell") as! BootDetailTableCell
        cell.lblDes.text =  strDes
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.frame.size.width
    }
    
    
    
    @IBOutlet var tblBootDetail:UITableView!
    
    
    
    
}
