//
//  BootDetailViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class BootDetailViewController: UIViewController,BootDetailScrollTopCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var lblFirstName:UILabel!
    @IBOutlet var lblPosition:UILabel!
    @IBOutlet var imgProfile:UIImageView!
    @IBOutlet var scrollTop:UICollectionView!
    @IBOutlet var scrollBottom:UICollectionView!
    
    
     var imageCache = NSCache<NSString, UIImage>()
    
     var selectedIndexTopScroll = 0
    
    var objBootTeam = BootTeam()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellWidthTop : CGFloat = self.view.frame.size.width/3
        let cellheightTop : CGFloat = self.scrollTop.frame.size.height
        let cellSizeTop = CGSize(width: cellWidthTop , height:cellheightTop)
        
        let layoutTop = UICollectionViewFlowLayout()
        layoutTop.scrollDirection = .horizontal //.horizontal
        layoutTop.itemSize = cellSizeTop
        layoutTop.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutTop.minimumLineSpacing = 0.0
        layoutTop.minimumInteritemSpacing = 0.0
        self.scrollTop.setCollectionViewLayout(layoutTop, animated: true)
        
        
        
        
        let cellWidth : CGFloat = self.view.frame.size.width
        let cellheight : CGFloat = self.scrollBottom.frame.size.height
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        self.scrollBottom.frame = CGRect(x: self.scrollBottom.frame.origin.x, y: self.scrollBottom.frame.origin.y, width: self.view.frame.size.width, height: self.scrollBottom.frame.size.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        self.scrollBottom.setCollectionViewLayout(layout, animated: true)
        
        
        self.lblFirstName.text = self.objBootTeam.FirstName
        self.lblPosition.text = self.objBootTeam.Position
        
        print(self.objBootTeam.profile_url)
        
        if(self.imageCache.object(forKey:self.objBootTeam.profile_url! as NSString) != nil){
            
            self.imgProfile.image = self.imageCache.object(forKey:self.objBootTeam.profile_url! as NSString)
            
        }else{
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = NSURL(string: self.objBootTeam.profile_url!) {
                    
                    do {
                        if let data =  NSData(contentsOf: url as URL) {
                            let image: UIImage = UIImage(data: data as Data)!
                            self.imageCache.setObject(image, forKey:self.objBootTeam.profile_url! as NSString)
                            DispatchQueue.main.async {
                                self.imgProfile.image  = image
                            }
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIBUtton Actions
    @IBAction func btnBack(sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var rowCount =  0
        if collectionView.tag == 1
        {
            rowCount = 3
        }
        else if collectionView.tag == 2
        {
            rowCount = 3
        }
        
        return rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var commanCell:UICollectionViewCell!
        
        if collectionView.tag == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BootDetailScrollTopCell", for: indexPath) as! BootDetailScrollTopCell
            cell.delegate = self
           // cell.delegate = self
            cell.btnTop.tag = indexPath.item
            cell.viewBottomLine.backgroundColor =  UIColor.white
            cell.lblTitle.textColor =  UIColor.black
            
            if indexPath.item  == 0
            {
                cell.lblTitle.text =  "BIOGRAPHY"
            }
            else if indexPath.item == 1
            {
                cell.lblTitle.text =  "POSITION"
            }
            else if indexPath.item == 2
            {
                cell.lblTitle.text =  "ORGANIZATION"
            }
            
            if self.selectedIndexTopScroll ==  indexPath.item
            {
                cell.viewBottomLine.backgroundColor =  UIColor.red
                cell.lblTitle.textColor = UIColor.red
            }
            commanCell =  cell
        }
        else if collectionView.tag == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BootTeamDetailCell", for: indexPath) as! BootTeamDetailCell
            if indexPath.item == 0
            {
                cell.strDes = self.objBootTeam.Biography
            }
            else if indexPath.item == 1
            {
                 cell.strDes = self.objBootTeam.Position
            }
            else if indexPath.item == 2
            {
                 cell.strDes = self.objBootTeam.level
            }
            cell.tblBootDetail.reloadData()
            commanCell =  cell
            
        }
        
        return commanCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if self.selectedIndexTopScroll != indexPath.row {
//            self.selectedIndexTopScroll = indexPath.row
//        }
//    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.tag == 2
        {
            let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
            self.selectedIndexTopScroll =  Int(round(scrollIndex))
             self.scrollTop.scrollToItem(at: IndexPath.init(row:self.selectedIndexTopScroll , section: 0), at: .centeredHorizontally, animated: true)
            self.scrollTop.reloadData()
        }
        
    }
    
    //MARK: Custome delegate
    
    func getCurrentIndex(current: Int) {
        
        self.selectedIndexTopScroll =  current
        self.scrollTop.scrollToItem(at: IndexPath.init(row: current, section: 0), at: .centeredHorizontally, animated: true)
        self.scrollBottom.scrollToItem(at: IndexPath.init(row: current, section: 0), at: .centeredHorizontally, animated: true)
        self.scrollTop.reloadData()
        
    }

   

}
