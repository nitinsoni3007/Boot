//
//  VideoViewController.swift
//  BOOT
//
//  Created by snehil on 07/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos

class VideoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, VideoCellDelegate{

    var arrVideoList = [VideoList]()
    @IBOutlet var tblVideoList:UITableView!
    
    var cache:NSCache<AnyObject, AnyObject>!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.cache = NSCache()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.getVideoList()

    }

    //MARK: Api Calling
    
    func getVideoList()
    {
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApi(strAction:webServiceActions.Video , strWebType: "GET", params: [:]) { (dict) in
            
            let dict:NSMutableDictionary = dict as! NSMutableDictionary
            print(dict)
            ActivityController().hideActivityIndicator(uiView: self.view)
            
            let arrTemparr = dict.object(forKey: "video_data") as! NSArray
            
            for (_,dict) in arrTemparr.enumerated()
            {
                let dictVideo = dict as! NSMutableDictionary
                let objVideoList = VideoList()
               
                objVideoList.ID =  dictVideo.object(forKey: "ID") as! String
                objVideoList.SortNo =  dictVideo.object(forKey: "SortNo") as! String
                objVideoList.videoname = dictVideo.object(forKey: "videoname") as! String
                objVideoList.videopath = dictVideo.object(forKey: "videopath") as! String
                objVideoList.thumbnailpath = dictVideo.object(forKey:"thumbnailpath") as! String
                self.arrVideoList.append(objVideoList)
             }
            
              self.tblVideoList.reloadData()
            }
        }
    
    //MARK: UItableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrVideoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        let objVideoList = self.arrVideoList[indexPath.row]
        cell.btnShareVideo.tag = indexPath.row
        cell.delegate = self
        
        cell.lblTitle.text =   objVideoList.videoname as! String
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            print("Cached image used, no need to download it")
            cell.imgThumb.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }
        else
        {
            cell.imgThumb.image =  UIImage(named:"");
            
            let url:URL  = URL(string: objVideoList.thumbnailpath)!
          
          
            task = session.downloadTask(with: url , completionHandler: { (location, response, error) in
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        if (self.tblVideoList.cellForRow(at: indexPath)as? VideoCell) != nil {
                            
                            let img:UIImage! = UIImage(data: data as Data)
                            cell.imgThumb.image = img
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let objVideoList = self.arrVideoList[indexPath.row]
        let videoURL = URL(string: objVideoList.videopath)
        
        downloadVideoLinkAndCreateAsset(objVideoList.videopath)
        
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    //MARK: UIbutto Action
    @IBAction func btnBack(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Download video from url
    
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            
            // set up your download task
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                
                // use guard to unwrap your optional url
                guard let location = location else { return }
                
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                
                do {
                    
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    
                    PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                        
                        // check if user authorized access photos for your app
                        if authorizationStatus == .authorized {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                    if completed {
                                        print("Video asset created")
                                    } else {
                                        print(error)
                                        //file:///Users/manishpathak/Library/Developer/CoreSimulator/Devices/40CB0327-417E-4D10-99ED-8F48C2A099ED/data/Containers/Data/Application/52FA5A2E-B369-4A3E-93FB-67BC6C3703C7/Documents/videoplayback.mp4
                                    }
                            }
                        }
                    })
                    
                } catch { print(error) }
                
                }.resume()
            
        } else {
            
            print("File already exists at destination url")
            
            guard let videoURL = URL(string: videoLink) else { return }
            
            let fm = FileManager.default
            let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let path = docsurl.appendingPathComponent(videoURL.lastPathComponent)
             playVideo(filePath: path.path)
            
        }
            
    }
    
    func playVideo(filePath:String)
    {
        let player = AVPlayer(url: URL(fileURLWithPath: filePath))
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
    //MARK: Custome Delegate
   
    func getCurrentBtnIndex(currentIndex: Int) {
        
          let objVideoList = self.arrVideoList[currentIndex]
          ViewBorder.shareViewBorder.shareVideo(strVideoUrl: objVideoList.videopath, objViw: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
