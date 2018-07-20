//
//  BootTeamCell.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

protocol BootTeamCellDeleagte {
    
    func callNextBootDetail(currentIndex:Int)
}


import UIKit

class BootTeamCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tblBootTeam:UITableView!
    var imageCache = NSCache<NSString, UIImage>()
    var delegate:BootTeamCellDeleagte!
    
    
    var arrBotTeam = [BootTeam]()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBotTeam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BootTamTableCell") as! BootTamTableCell
        let objBootTeam =  self.arrBotTeam[indexPath.row]
        print(objBootTeam.MiddleName)
        cell.lblFirstName.text =  objBootTeam.FirstName
        cell.lblOssition.text =  objBootTeam.Position
       
        if(self.imageCache.object(forKey:objBootTeam.profile_url as String as NSString) != nil){
            
            cell.imgProfile.image = self.imageCache.object(forKey:objBootTeam.profile_url as String as NSString)
            
        }else{
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = NSURL(string: objBootTeam.profile_url ) {
                    
                    do {
                        if let data =  NSData(contentsOf: url as URL) {
                            let image: UIImage = UIImage(data: data as Data)!
                            self.imageCache.setObject(image, forKey: objBootTeam.profile_url as NSString)
                            DispatchQueue.main.async {
                                cell.imgProfile.image  = image
                            }
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        return cell
    }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print(indexPath.row)
        delegate.callNextBootDetail(currentIndex: indexPath.row)
    }

}
