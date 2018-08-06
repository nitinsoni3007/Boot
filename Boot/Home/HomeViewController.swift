//
//  HomeViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var scrollTop:UIScrollView!
    @IBOutlet var scrollBottom:UIScrollView!
    @IBOutlet var collectionHome:UICollectionView!
    
    
    var items = [[String: String]]()
    var viewObjects =  [UIImageView]()
    var viewObjectsBottom =  [UIImageView]()
    var numPages: Int = 0
    var numPagesBottom: Int = 0
    
     var imageCache = NSCache<NSString, UIImage>()
    var imgGlobal:UIImageView!
    var arrAddBar = [AddBar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.items =  [["imgName":"ManiFesto.png", "name":"ManiFesto"],["imgName":"meet_our_team.png", "name":"BootTeam"],["imgName":"our_policy_video.png", "name":"VideoManiFesto"],["imgName":"policy_forum.png", "name":"PolicyForm"],["imgName":"join_us.png", "name":"JoinUs"],["imgName":"news_icon.png", "name":"Latest"],["imgName":"aboutus.png", "name":"AboutUs"],["imgName":"facebook.png", "name":"SocialMedia"],["imgName":"youtube.png", "name":"VideoGallary"],["imgName":"donate.png", "name":"Finance"],["imgName":"social_feeds.png", "name":"SocialFeeds"],["imgName":"event_schedule.png", "name":"Event/Shedule"],["imgName":"volunteer.png", "name":"Volunteer"],["imgName":"my_profile.png", "name":"MyProfile"],["imgName":"faq.png", "name":"FAQs"],["imgName":"e_flyer.png", "name":"e-Flyer"],["imgName":"online_tools.png", "name":"Online Tools"],["imgName":"share.png", "name":"Share"],["imgName":"feedback.png", "name":"Feedback"],["imgName":"vote.png", "name":"VoteWare"],["imgName":"help_desk.png", "name":"Help Desk"]]
        
        
       Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextPageSrollTop), userInfo: nil, repeats: true)
       Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextPageSrollBottom), userInfo: nil, repeats: true)
        
        let cellWidth : CGFloat = self.view.frame.size.width / 3.0
        let cellheight : CGFloat = self.view.frame.size.width / 3.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        self.collectionHome.setCollectionViewLayout(layout, animated: true)
        
       /* if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
        }*/
        
        
        if Reachability.isConnectedToNetwork() {
            print("Connected")
        }
        else{
            print("disConnected")
        }
        
        
        self.getAppParam()
        
        //self.getAddBar()
        
        
    }
    
    @objc func moveToNextPageSrollTop (){
        
        let pageWidth:CGFloat = self.scrollTop.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(numPages)
        let contentOffset:CGFloat = self.scrollTop.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollTop.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollTop.frame.height), animated: false)
    }
    
    @objc func moveToNextPageSrollBottom (){
        
        let pageWidth:CGFloat = self.scrollBottom.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(numPagesBottom)
        let contentOffset:CGFloat = self.scrollBottom.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollBottom.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollBottom.frame.height), animated: false)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath as IndexPath) as! itemCell
        cell.imgHome.image = UIImage(named: self.items[indexPath.row]["imgName"]!)
        cell.lblHome.text = self.items[indexPath.row]["name"]
        ViewBorder.shareViewBorder.borderView(objView: cell.cellBorderView, objcolor: UIColor.white)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if indexPath.item == 0
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainFestoViewController") as! MainFestoViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 1
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "BootTeamViewController") as! BootTeamViewController
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        else if indexPath.row == 2
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 3
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PolicyForamViewController") as! PolicyForamViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 4
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 6
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 9
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FinanceViewController") as! FinanceViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 11
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EventNScheduleViewController") as! EventNScheduleViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 12
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "VolunteerViewController") as! VolunteerViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 13
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 14
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 15
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EFlyrViewController") as! EFlyrViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 16
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "OnlineToolsViewController") as! OnlineToolsViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 17
        {
            let textToShare = "<html><body>Hi there, I joined the BOOT Party and I am using the BOOT Party iOS app.<br>The BOOT Party is a new political leadership system with breath of fresh ari, vision and deremination to redeem the Nigerian Dreams.<br>Getinvolved! Join the BOOT party <a href='https://www.BOOT.org.ng'>BOOT</a>.<br>Download BOOT Party app on your Mobile device.<br><b>BOOT Party!\nBecause Of Our Tomorrow!</b></body></html>"

            let activityController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = self.view
            self.present(activityController, animated: true, completion: nil)
        }
        else if indexPath.row == 19
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "VoteWareViewController") as! VoteWareViewController
            navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 20
        {
            let storyboard = UIStoryboard(name: "SecondStoryBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HelpDeskViewController") as! HelpDeskViewController
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    
    //MARK: Web Service Call
    func getAppParam()
    {
        
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().getApplicationParam(strAction: WebServiceConstans.APP_PARAMETER, strwbType: "GET", dict: [:]) { (dict) in
            
            ActivityController().hideActivityIndicator(uiView: self.view)
//            var dictAppParam:NSMutableDictionary = NSMutableDictionary()
            guard let dictAppParam = dict.object(forKey:"applicationparameters_data") as? NSMutableDictionary else {
                return
            }
            
            AppParam.shareAppParam.logo_placeholder =  dictAppParam.object(forKey: "logo_placeholder") as! String
            
            let arrImgPacehiolderTemp: NSArray = dictAppParam.object(forKey:"image_placeholder") as! NSArray
            
            for (_, strImageUrl) in arrImgPacehiolderTemp.enumerated()
            {
                AppParam.shareAppParam.arrimage_placeholder.append(strImageUrl as! String)
            }
            
            AppParam.shareAppParam.name1_placeholder =  dictAppParam.object(forKey: "name1_placeholder") as! String
            AppParam.shareAppParam.name2_placeholder =  dictAppParam.object(forKey: "name2_placeholder") as! String
            AppParam.shareAppParam.name3_placeholder =  dictAppParam.object(forKey: "name3_placeholder") as! String
            AppParam.shareAppParam.facebook_web_view = dictAppParam.object(forKey: "facebook_web_view") as! String
            AppParam.shareAppParam.youtube_web_view = dictAppParam.object(forKey: "youtube_web_view") as! String
            
            AppParam.shareAppParam.twitter_web_view = dictAppParam.object(forKey: "twitter_web_view") as! String
            AppParam.shareAppParam.instagram_web_view = dictAppParam.object(forKey: "instagram_web_view") as! String
            AppParam.shareAppParam.google_play_store_downloadable_link = dictAppParam.object(forKey: "google_play_store_downloadable_link") as! String
            AppParam.shareAppParam.app_store_downloadable_link = dictAppParam.object(forKey: "app_store_downloadable_link") as! String
            AppParam.shareAppParam.admin_email = dictAppParam.object(forKey: "admin_email") as! String
            AppParam.shareAppParam.linkedin_web_view = dictAppParam.object(forKey: "linkedin_web_view") as! String
            AppParam.shareAppParam.prized_event_web_url = dictAppParam.object(forKey: "prized_event_web_url") as! String
            AppParam.shareAppParam.join_counter = dictAppParam.object(forKey: "join_counter") as! String
            AppParam.shareAppParam.edit_profile = dictAppParam.object(forKey: "edit_profile") as! String
            //AppParam.shareAppParam.total_likes = dictAppParam.object(forKey: "total_likes") as! String
            
             self.loadTopScroll()
           
            
        }
       
    }
    
    func getAddBar()
    {
        ApiService().getApplicationParam(strAction: WebServiceConstans.Addbar, strwbType: "GET", dict: [:]) { (dictAppBar) in
            
            let arrTemp  =   dictAppBar.object(forKey: "add_bar") as! NSArray
            
            for (_, dict) in arrTemp.enumerated()
            {
                let dictTemp:NSMutableDictionary = dict as! NSMutableDictionary
                
                let objAddBar =  AddBar()
                objAddBar.id = dictTemp.object(forKey: "id") as? String
                objAddBar.image_url = dictTemp.object(forKey: "image_url") as? String
                objAddBar.refer_url = dictTemp.object(forKey: "refer_url") as? String
                objAddBar.active = dictTemp.object(forKey: "active") as? String
                objAddBar.count = dictTemp.object(forKey: "count") as? String
                self.arrAddBar.append(objAddBar)
                
            }
            
          //  self.loadBottomScroll()
            
        }
    }
    
    
    func loadTopScroll()
    {
       
        for (_,_) in AppParam.shareAppParam.arrimage_placeholder.enumerated()
        {
            let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:self.view.frame.size.width, height:self.scrollTop.frame.size.height))
             imgOne.image = UIImage(named: "")
             viewObjects.append(imgOne)
        }
        numPages = viewObjects.count
        self.scrollTop.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollTop.frame.size.height)
        self.scrollTop.contentSize = CGSize(width: (self.view.frame.size.width * (CGFloat(numPages))), height: self.scrollTop.frame.size.height)
        
        loadScrollViewWithPage(page: 0)
        loadScrollViewWithPage(page: 1)
        loadScrollViewWithPage(page: 2)
        
        var newFrame = self.scrollTop.frame
        newFrame.origin.x = 0
        newFrame.origin.y = 0
        self.scrollTop.scrollRectToVisible(newFrame, animated: false)
    }
    
    func loadBottomScroll()
    {
        
        for (_,_) in self.arrAddBar.enumerated()
        {
            let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:self.view.frame.size.width, height:self.scrollBottom.frame.size.height))
            imgOne.image = UIImage(named: "")
            viewObjectsBottom.append(imgOne)
        }
        numPagesBottom = viewObjectsBottom.count
        self.scrollBottom.frame = CGRect(x: 0, y: self.scrollBottom.frame.origin.y, width: self.view.frame.size.width, height: self.scrollBottom.frame.size.height)
        self.scrollBottom.contentSize = CGSize(width: (self.view.frame.size.width * (CGFloat(numPagesBottom))), height: self.scrollBottom.frame.size.height)
        
        loadScrollViewWithPageBottom(page: 0)
        loadScrollViewWithPageBottom(page: 1)
        loadScrollViewWithPageBottom(page: 2)
        
        var newFrame = self.scrollBottom.frame
        newFrame.origin.x = 0
        //newFrame.origin.y = 0
        self.scrollBottom.scrollRectToVisible(newFrame, animated: false)
    }
    
    //Method for SrollTop
    private func loadScrollViewWithPage(page: Int) {
        if page < 0 { return }
        if page >= numPages + 2 { return }
        
        var index = 0
        
        if page == 0 {
            index = numPages - 1
        } else if page == numPages + 1 {
            index = 0
        } else {
            index = page - 1
        }
        
        let view = viewObjects[index]
        
        //Get Image From Server
        
        if(self.imageCache.object(forKey:  AppParam.shareAppParam.arrimage_placeholder[index] as NSString) != nil){
            
            view.image = self.imageCache.object(forKey:  AppParam.shareAppParam.arrimage_placeholder[index] as NSString)
            //cell.imgConfigurr.image = self.imageCache.object(forKey: strimgUrl as NSString)
        }else{
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = NSURL(string:  AppParam.shareAppParam.arrimage_placeholder[index]) {
                    
                    do {
                        
                        if let data =  NSData(contentsOf: url as URL) {
                            let image: UIImage = UIImage(data: data as Data)!
                            self.imageCache.setObject(image, forKey:  AppParam.shareAppParam.arrimage_placeholder[index] as NSString)
                            DispatchQueue.main.async {
                                view.image  = image
                            }
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        var newFrame = self.scrollTop.frame
        newFrame.origin.x = self.scrollTop.frame.size.width * CGFloat(page)
        newFrame.origin.y = 0
        view.frame = newFrame
        
        if view.superview == nil {
            self.scrollTop.addSubview(view)
        }
        
    }
    
    //Method for Bottom Scroll
    private func loadScrollViewWithPageBottom(page: Int) {
       
        if page < 0 { return }
        if page >= numPagesBottom + 2 { return }
        
        var index = 0
        
        if page == 0 {
            index = numPagesBottom - 1
        } else if page == numPagesBottom + 1 {
            index = 0
        } else {
            index = page - 1
        }
        
        let view = viewObjectsBottom[index]
        
        //Get Image From Server
        
        
        let objAddBar =  self.arrAddBar[index]
        
        
        let result3 = String((objAddBar.image_url?.dropLast(1))!)    // "he"
        let result4 = String(result3.dropFirst(1))
        
        print(result4)
        
        if(self.imageCache.object(forKey:result4 as String as NSString) != nil){
            
            view.image = self.imageCache.object(forKey:result4 as String as NSString)
           
        }else{
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = NSURL(string: result4 ) {
                   
                    do {
                        if let data =  NSData(contentsOf: url as URL) {
                            let image: UIImage = UIImage(data: data as Data)!
                            self.imageCache.setObject(image, forKey:  result4 as NSString)
                            DispatchQueue.main.async {
                                view.image  = image
                            }
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        var newFrame = self.scrollBottom.frame
        newFrame.origin.x = self.scrollBottom.frame.size.width * CGFloat(page)
        newFrame.origin.y = 0
        view.frame = newFrame
        
        if view.superview == nil {
            self.scrollBottom.addSubview(view)
        }
        
    }
    
    
    // 5
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - (pageWidth/2)) / pageWidth) + 1
        
        if scrollView == self.scrollTop
        {
            loadScrollViewWithPage(page: Int(page - 1))
            loadScrollViewWithPage(page: Int(page))
            loadScrollViewWithPage(page: Int(page + 1))
        }
        else
        {
//            loadScrollViewWithPageBottom(page: Int(page - 1))
//            loadScrollViewWithPageBottom(page: Int(page))
//            loadScrollViewWithPageBottom(page: Int(page + 1))
        }
        
    }
    
    // 6
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.view.frame.size.width
        let page : Int = Int(floor((scrollView.contentOffset.x - (pageWidth/2)) / pageWidth) + 1)
        
        if page == 0 {
            //self.scrollTop.contentOffset = CGPoint(x: pageWidth*(CGFloat(numPages)), y: 0)
        } else if page == numPages+1 {
            //  self.scrollTop.contentOffset = CGPoint(x: pageWidth, y: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
