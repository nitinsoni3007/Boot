//
//  WebServiceActions.swift
//  BOOT
//
//  Created by Manish Pathak on 07/06/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

struct WebServiceConstans {
    
   // static let BaseUrlLocal = "http://www.adenuga.org/BOOT_Event/index.php/"
    static let BaseUrl = "https://www.boot.org.ng/boot_test/index.php/"
    
    static let APP_PARAMETER = "applicationparameters"
    static let Addbar =  "AddBar"
    static let Policy = "policy"
    static let Video = "video"
    static let Title = "title"
    static let State = "ngstates"
    static let AdminIEMINumber = "AdminImeiNumber"
    static let BallotLike = "Ballotlike"
    static let BallotGpPositions = "BallotGroupParameter/get_position"
    static let VolunteerField = "volunteerfield"
    static let LocalGoverment = "nglga"
    static let Ward = "Ngward"
    static let ProfileJoinUs =  "profilejoinus/insert"
    static let ProfileLogin = "profilejoinus/login"
    static let VoterLoginVote = "Profilejoinus/login_vote"
    static let AdminLoginVote = "AdminVoteLogin/login_vote"
    static let CheckVote = "Ballotvote/check_vote"
    static let CandidateList = "Ballotpoll/get_candidate_list"
    static let CastVote = "ballotvote/cast_vote"
    static let OnlineTools = "OnlineTool"
    static let FAQs = "faq/get_list_with_ans"
    static let EFlyer = "ebanner"
    static let kAccountNumber = "acctno"
    static let kVoterAccountNumber = "account_no"
    static let kIsVoted = "is_voted"
    static let kIsLiked = "is_liked"
    static let kIsAdmin = "is_admin"
    static let kNotificationLogVoterOut = "logVoterOut"
}

struct alertKeys {
    
    static let ALERTMESSAGE = "Oops!"
    static let ALERTTITLE = "Please Insert Required Filed"
    
}
