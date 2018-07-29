//
//  EFlyrViewController.swift
//  Boot
//
//  Created by snehil on 27/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

class EFlyrViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var arrEFlyr = [EFlyr]()
    @IBOutlet var collectionHome:UICollectionView!
    
    var cache:NSCache<AnyObject, AnyObject>!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cache = NSCache()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        let cellWidth : CGFloat
        let cellheight : CGFloat
       
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            cellWidth = self.view.frame.size.width / 4.0
            cellheight = self.view.frame.size.width / 4.0
            
        }
        else
        {
            cellWidth = self.view.frame.size.width / 2.0
            cellheight = self.view.frame.size.width / 2.0
           // let cellSize = CGSize(width: cellWidth , height:cellheight)
        }
        
        let cellSize = CGSize(width: cellWidth , height:cellheight)
       
        
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        self.collectionHome.setCollectionViewLayout(layout, animated: true)
        
        self.getEFlyer()
    }
    
    //MARK: UIWebServiceCall
    
    func getEFlyer()
    {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApi(strAction: webServiceActions.EFlyer, strWebType:"GET" , params: [:]) { (dict) in
        
            ActivityController().hideActivityIndicator(uiView: self.view)
            let dictTemp:NSMutableDictionary =  dict as! NSMutableDictionary
            let arrTemp  = dictTemp.object(forKey: "ebanner_data") as! NSArray
            for (_, dict) in arrTemp.enumerated()
            {
               let dictEFlyr  =  dict as! NSMutableDictionary
               let objEFlyr =  EFlyr()
                objEFlyr.ID = dictEFlyr.object(forKey: "ID") as? String
                objEFlyr.SortNo =  dictEFlyr.object(forKey: "SortNo")  as? String
              
                objEFlyr.image_title = dictEFlyr.object(forKey: "image_title") as? String
                objEFlyr.image_path = dictEFlyr.object(forKey: "image_path") as? String
                objEFlyr.live =  dictEFlyr.object(forKey: "live") as? String
                objEFlyr.entryby =  dictEFlyr.object(forKey: "entryby") as? String
                objEFlyr.entryby =  dictEFlyr.object(forKey: "entryby")  as? String
                self.arrEFlyr.append(objEFlyr)
            }
            self.collectionHome.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrEFlyr.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let objEFlyr =  self.arrEFlyr[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EFlyrCell", for: indexPath as IndexPath) as! EFlyrCell
       cell.lblTitle.text = objEFlyr.image_title
       
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            print("Cached image used, no need to download it")
            cell.imgProfile.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
           
        }
        else
        {
            cell.imgProfile.image =  UIImage(named:"");
            
            let url:URL  = URL(string: objEFlyr.image_path!)!
            
            task = session.downloadTask(with: url , completionHandler: { (location, response, error) in
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        if (self.collectionHome.cellForItem(at: indexPath)as? EFlyrCell) != nil {
                            
                            let img:UIImage! = UIImage(data: data as Data)
                            cell.imgProfile.image = img
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
            
            
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let cell = self.collectionHome!.cellForItem(at: indexPath) as! EFlyrCell
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EFlyrDetailViewController") as! EFlyrDetailViewController
        controller.imgProfile = cell.imgProfile.image
        controller.strTitle = cell.lblTitle.text
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: UITableview Delegate
    
    @IBAction func btnback(sender:UIButton)
    {
       self.navigationController?.popViewController(animated: true)
    }

    

}
