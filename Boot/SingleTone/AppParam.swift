//
//  AppParam.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class AppParam: NSObject {
   
    static let shareAppParam =  AppParam()
    
    
    var logo_placeholder:String!
    var arrimage_placeholder = [String]()
    
    var name1_placeholder:String!
    var name2_placeholder:String!
    var name3_placeholder:String!
    var facebook_web_view:String!
    var youtube_web_view:String!
    var twitter_web_view:String!
    var instagram_web_view:String!
    var google_play_store_downloadable_link:String!
    var app_store_downloadable_link:String!
    var admin_email:String!
    var linkedin_web_view:String!
    var prized_event_web_url:String!
    var join_counter:String!
    var edit_profile:String!
    var total_likes:String!
    
    private override init() {
        
    }

}
