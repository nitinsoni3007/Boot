//
//  BootTeamViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 14/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class BootTeamViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,TopSliderCellDelegate,BootTeamCellDeleagte {
    
    @IBOutlet var collectionTopScroll:UICollectionView!
    @IBOutlet var collectionBootTeam:UICollectionView!
    
    var arrBootTeam = [BootTeam]()
    var arrcouncil_data =  [BootTeam]()
    var arrOfficers_model =  [BootTeam]()
    
    var selectedIndexTopScroll = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellWidth : CGFloat = self.view.frame.size.width
        let cellheight : CGFloat = self.collectionBootTeam.frame.size.height
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        
        let cellWidthTop : CGFloat = self.view.frame.size.width/3
        let cellheightTop : CGFloat = self.collectionTopScroll.frame.size.height
        let cellSizeTop = CGSize(width: cellWidthTop , height:cellheightTop)
        
        
        self.collectionBootTeam.frame = CGRect(x: self.collectionBootTeam.frame.origin.x, y: self.collectionBootTeam.frame.origin.y, width: self.view.frame.size.width, height: self.collectionBootTeam.frame.size.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        self.collectionBootTeam.setCollectionViewLayout(layout, animated: true)
        
        
        let layoutTop = UICollectionViewFlowLayout()
        layoutTop.scrollDirection = .horizontal //.horizontal
        layoutTop.itemSize = cellSizeTop
        layoutTop.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutTop.minimumLineSpacing = 0.0
        layoutTop.minimumInteritemSpacing = 0.0
        self.collectionTopScroll.setCollectionViewLayout(layoutTop, animated: true)
  
        
        
        self.getBootTeamRecored()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopSliderCell", for: indexPath) as! TopSliderCell
            cell.delegate = self
            cell.btnTop.tag = indexPath.row
            cell.viewBottomLine.backgroundColor =  UIColor.white
            cell.lblTitle.textColor = UIColor.black
            
            if indexPath.row  == 0
            {
                cell.lblTitle.text =  "COUNCIL"
            }
            else if indexPath.row == 1
            {
                cell.lblTitle.text =  "OFFICERS"
            }
            else if indexPath.row == 2
            {
                cell.lblTitle.text =  "BOOT CADIDATES"
            }
            
            if self.selectedIndexTopScroll ==  indexPath.row
            {
                cell.viewBottomLine.backgroundColor =  UIColor.red
                cell.lblTitle.textColor = UIColor.red
            }
            commanCell =  cell
        }
        else if collectionView.tag == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BootTeamCell", for: indexPath) as! BootTeamCell
            cell.delegate = self
            cell.arrBotTeam.removeAll()
            
            if self.selectedIndexTopScroll == 0
            {
                 cell.arrBotTeam =  self.arrBootTeam
            }
            else if self.selectedIndexTopScroll == 1
            {
                 cell.arrBotTeam =  self.arrcouncil_data
            }
            else
            {
                 cell.arrBotTeam =  self.arrOfficers_model
            }
            
          
            cell.tblBootTeam.reloadData()
            commanCell =  cell
            
        }

        return commanCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedIndexTopScroll != indexPath.row {
            self.selectedIndexTopScroll = indexPath.row
            
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": self.selectedIndexTopScroll])
            
            // NotificationCenter.default.post(name: Notification.Name.init(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": self.selectedIndex])
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.tag == 2
        {
            let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
            self.selectedIndexTopScroll =  Int(scrollIndex)
            
            print(self.selectedIndexTopScroll)
            
             self.collectionTopScroll.scrollToItem(at: IndexPath.init(row:self.selectedIndexTopScroll , section: 0), at: .centeredHorizontally, animated: true)
            self.collectionTopScroll.reloadData()
            self.collectionBootTeam.reloadData()
        }
       
    }
    
    //MARK: CUstome Delegate
    
    func getCurrentIndex(currentIndex: Int) {
        
        self.selectedIndexTopScroll =  currentIndex
        self.collectionTopScroll.scrollToItem(at: IndexPath.init(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionBootTeam.scrollToItem(at: IndexPath.init(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionTopScroll.reloadData()
        
    }
    
    func callNextBootDetail(currentIndex: Int) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BootDetailViewController") as! BootDetailViewController
        controller.objBootTeam = self.arrBootTeam[currentIndex]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    //MARK: UIWeb Service Call
    
    func getBootTeamRecored()
    {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().getBootTeamRecored(strAction: "ourteam/get_list", strwbType: "GET", dict: [:]) { (dictBootTeam) in
            print(dictBootTeam)
            
            
            ActivityController().hideActivityIndicator(uiView: self.view)
            let dictTemp =  dictBootTeam
            let arrTemp = dictTemp.object(forKey: "ourteam_data") as? NSArray ?? NSArray()
            
            for (_, dict) in arrTemp.enumerated()
            {
                let dicttemp =  dict as! NSMutableDictionary
                let objBootTeam = BootTeam()
                
                 objBootTeam.ID =  dicttemp.object(forKey: "ID") as! String
                 objBootTeam.FirstName =  dicttemp.object(forKey: "FirstName") as! String
                 objBootTeam.MiddleName =  dicttemp.object(forKey: "MiddleName") as! String
                 objBootTeam.Surname =  dicttemp.object(forKey: "Surname") as! String
                 objBootTeam.Position =  dicttemp.object(forKey: "Position") as! String
                 objBootTeam.profile_url =  dicttemp.object(forKey: "profile_url") as! String
                 objBootTeam.Biography =  dicttemp.object(forKey: "Biography") as! String
                 objBootTeam.level =  dicttemp.object(forKey: "level") as! String
               // council_data
                //Officers_model
                self.arrBootTeam.append(objBootTeam)
            }
            
            let arrTempcouncil_data = dictTemp.object(forKey: "council_data") as? NSArray ?? NSArray()
            
            for (_, dict) in arrTempcouncil_data.enumerated()
            {
                let dicttemp =  dict as! NSMutableDictionary
                let objBootTeam = BootTeam()
                
                objBootTeam.ID =  dicttemp.object(forKey: "ID") as! String
                objBootTeam.FirstName =  dicttemp.object(forKey: "FirstName") as! String
                objBootTeam.MiddleName =  dicttemp.object(forKey: "MiddleName") as! String
                objBootTeam.Surname =  dicttemp.object(forKey: "Surname") as! String
                objBootTeam.Position =  dicttemp.object(forKey: "Position") as! String
                objBootTeam.profile_url =  dicttemp.object(forKey: "profile_url") as! String
                objBootTeam.Biography =  dicttemp.object(forKey: "Biography") as! String
                objBootTeam.level =  dicttemp.object(forKey: "level") as! String
                // council_data
                //Officers_model
                self.arrcouncil_data.append(objBootTeam)
            }
            
            let arrOfficers_model = dictTemp.object(forKey: "Officers_model") as? NSArray ?? NSArray()
            
            for (_, dict) in arrOfficers_model.enumerated()
            {
                let dicttemp =  dict as! NSMutableDictionary
                let objBootTeam = BootTeam()
                
                objBootTeam.ID =  dicttemp.object(forKey: "ID") as! String
                objBootTeam.FirstName =  dicttemp.object(forKey: "FirstName") as! String
                objBootTeam.MiddleName =  dicttemp.object(forKey: "MiddleName") as! String
                objBootTeam.Surname =  dicttemp.object(forKey: "Surname") as! String
                objBootTeam.Position =  dicttemp.object(forKey: "Position") as! String
                objBootTeam.profile_url =  dicttemp.object(forKey: "profile_url") as! String
                objBootTeam.Biography =  dicttemp.object(forKey: "Biography") as! String
                objBootTeam.level =  dicttemp.object(forKey: "level") as! String
                self.arrOfficers_model.append(objBootTeam)
            }
            
            self.collectionBootTeam.reloadData()
        }
    }
    
    //MARK: UIBUtton Actions
    @IBAction func btnBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
