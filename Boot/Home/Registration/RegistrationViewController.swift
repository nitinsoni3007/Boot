//
//  RegistrationViewController.swift
//  BOOT
//
//  Created by Manish Pathak on 11/07/18.
//  Copyright © 2018 snehil. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    //Type 1  = Title
    

    @IBOutlet var srollRegistration: UIScrollView!
    @IBOutlet var scrollSubView: UIView!
    
    @IBOutlet var btnTitle:UIButton!
    @IBOutlet var btnGender:UIButton!
    @IBOutlet var btnAgeGroup:UIButton!
    @IBOutlet var btnState:UIButton!
    @IBOutlet var btnLocalGoverment:UIButton!
    @IBOutlet var btnWard:UIButton!
    @IBOutlet var btnAgree:UIButton!
    
    @IBOutlet var txtFirstName:UITextField!
    @IBOutlet var txtMiddleName:UITextField!
    @IBOutlet var txtLastName:UITextField!
    @IBOutlet var txtAddressLineOne:UITextField!
    @IBOutlet var txtAddressLineTwo:UITextField!
    @IBOutlet var txtCity:UITextField!
    @IBOutlet var txtPhoneNumber:UITextField!
    @IBOutlet var txtEmailAddress:UITextField!
    @IBOutlet var txtConfirmEmailAddress:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var txtConfirmPassword:UITextField!
    @IBOutlet var txtHowDidYouHereAboutUs:UITextField!
    
    
    @IBOutlet var pickerCommon:UIPickerView! // reusable picker view fro title, age, state etc
    @IBOutlet var viewPickerSuper:UIView!
    @IBOutlet var btnDone:UIButton!
    
    var selectedTitle:String! = ""
    var selectedTitleId:String! = ""
    
    var stateName:String = ""
    var stateCode:String = ""
    
    var btnType:Int = 0
    
    var arrlocalGoverMent = [LocalGoverment]()
    var arrWard =  [Ward]()
    
    
    var strLocalGovermentName:String! =  ""
    var strLocalGoverMentCode:String! = ""
    
    var strWardName:String! =  ""
    var strWardCode:String! = ""
    
    var isTermAndCondition:Bool =  false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         self.viewPickerSuper.frame = CGRect(x: 0, y: (1800 -  self.viewPickerSuper.frame.size.height) , width: self.view.frame.size.width, height:  self.viewPickerSuper.frame.size.height)
    }
    override func viewDidAppear(_ animated: Bool) {
       
        var contentRect = CGRect.zero
        
        for view in srollRegistration.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollSubView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: contentRect.size.height)
        srollRegistration.contentSize = contentRect.size
        
   }
    
    
    //MARK: UIButton Actions
    
    @IBAction func btnback(_sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOptions(sender:UIButton)
    {
     
        if sender.tag == 1
        {
            btnType = 1
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 1
            
        }
        else if sender.tag == 2
        {
             btnType = 2
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 2
            
        }
        else if sender.tag == 3
        {
             btnType = 3
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 3
        }
        else if sender.tag == 4
        {
             btnType = 4
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 4
        }
        else if sender.tag == 5
        {
            btnType = 5
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 5
        }
        else if sender.tag == 6
        {
            btnType = 6
            self.showAnimation()
            self.pickerCommon.reloadAllComponents()
            self.btnDone.tag = 6
        }
        
        
    }
    @IBAction func btnDone(sender:UIButton)
    {
        if btnType == 1 ||  btnType == 2 || btnType == 3 || btnType == 5 || btnType == 6
        {
             self.hideAnimation()
        }
        else if btnType == 4
        {
            self.getGovermentAndWard()
            self.hideAnimation()
        }
       
       
    }
    
    @IBAction func btnSubmit(sender:UIButton)
    {
        
        if (self.btnTitle.titleLabel?.text) == nil {
           
            self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select Title.")
            return
            
        }
        else if (txtFirstName.text == "" || txtFirstName.text == nil)
        {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed FirstName.")
             return
        }
        else if  (txtLastName.text == "" || txtLastName.text == nil)
        {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed LastName.")
             return
        }
        
        else  if (self.btnGender.titleLabel?.text) == nil {
            
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select Gender.")
             return
        }
        else  if (self.btnAgeGroup.titleLabel?.text) == nil
        {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select Agegroup.")
             return
        }
        else if (txtAddressLineOne.text == "" || txtAddressLineOne.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed AddressLineOne.")
             return
        }
        else if (txtCity.text == "" || txtCity.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed City.")
             return
        }
        else  if (self.btnState.titleLabel?.text) == nil {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select State.")
             return
        }
        else if (self.btnLocalGoverment.titleLabel?.text) == nil
        {
            self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select LocalgoverMent.")
             return
        }
        else if  (self.btnWard.titleLabel?.text) == nil
        {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Select Ward.")
             return
        }
        else if (txtPhoneNumber.text == "" || txtPhoneNumber.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed PhoneNumber.")
             return
            
        }
        else if  (txtEmailAddress.text == "" || txtEmailAddress.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed EmailAddress.")
             return
        }
        else if (txtConfirmEmailAddress.text == "" || txtConfirmEmailAddress.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed ConfirmationEmailAddress.")
             return
        }
        else if (txtPassword.text == "" || txtPassword.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed Password.")
            return
        }
        else if (txtConfirmEmailAddress.text == "" || txtConfirmEmailAddress.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed ConfirmPassword.")
             return
        }
        else if (txtHowDidYouHereAboutUs.text == "" || txtHowDidYouHereAboutUs.text == nil)
        {
              self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please Filed HowDidYouHereAboutUs.")
             return
        }
        else if !isTermAndCondition
        {
             self.showAleart(strTitle: alertKeys.ALERTMESSAGE, strMessage: "Please select term Conditions.")
             return
        }
        else
        {
            self.sendRegistrationParam()
        }
        
        
    }
    
    @IBAction func btnDontHaveEmailAddress(sender:UIButton)
    {
       
        if txtPhoneNumber.text == "" || txtPhoneNumber.text == nil
        {
            return
        }
        
        let btnImag = sender.image(for: .normal)
        
        if (btnImag == UIImage(named: "check")) {
            
            sender.setImage(UIImage(named: "uncheck"), for: .normal)
            self.txtEmailAddress.text =  ""
            self.txtConfirmEmailAddress.text = ""
            
        }
        else
        {
             sender.setImage(UIImage(named: "check"), for: .normal)
            self.txtEmailAddress.text =  self.txtPhoneNumber.text! +  "boot.co.in"
            self.txtConfirmEmailAddress.text =  self.txtPhoneNumber.text! +  "boot.co.in"
           
        }
        
    }
    
    @IBAction func btnTearmAndConditions(sender:UIButton)
    {
        
        let btnImag = sender.image(for: .normal)
        
        if (btnImag == UIImage(named: "check")) {
            
            sender.setImage(UIImage(named: "uncheck"), for: .normal)
             isTermAndCondition =  false
        }
        else
        {
            sender.setImage(UIImage(named: "check"), for: .normal)
            isTermAndCondition =  true
        }
        
    }
    
    //MARK: UITextFiled Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

    //MARK: UIPiclerview delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        var rowCount:Int = 0
        
        if btnType == 1
        {
            rowCount = ViewBorder.shareViewBorder.arrTitle.count
        }
        else if btnType == 2
        {
             rowCount = ViewBorder.shareViewBorder.arrGender.count
        }
        else if btnType == 3
        {
             rowCount = ViewBorder.shareViewBorder.arrAge.count
        }
        else if btnType == 4
        {
            rowCount = ViewBorder.shareViewBorder.arrState.count
        }
        else if btnType == 5
        {
            rowCount = self.arrlocalGoverMent.count
        }
        else if btnType == 6
        {
            rowCount = self.arrWard.count
        }
        return rowCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var strTitleCommon:String = ""
        if btnType == 1
        {
            let objTitle =  ViewBorder.shareViewBorder.arrTitle[row]
            strTitleCommon = objTitle.titlename!
        }
        else if btnType == 2
        {
          strTitleCommon =  ViewBorder.shareViewBorder.arrGender[row]
        }
        else if btnType == 3
        {
            strTitleCommon =  ViewBorder.shareViewBorder.arrAge[row]
        }
        else if btnType == 4
        {
            let objState = ViewBorder.shareViewBorder.arrState[row]
            strTitleCommon = objState.state
            self.stateName =  objState.state
            self.stateCode = objState.StateCode
        }
        else if btnType == 5
        {
            let objLocalGoverment =  self.arrlocalGoverMent[row]
            strTitleCommon = objLocalGoverment.lganame!
          
        }
        
        else if btnType == 6
        {
            let objWard =  self.arrWard[row]
            strTitleCommon = objWard.WardName!
            
        }
        return strTitleCommon
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if btnType == 1
        {
            let objTitle = ViewBorder.shareViewBorder.arrTitle[row]
            self.selectedTitle = objTitle.titlename!
            self.btnTitle.setTitle(objTitle.titlename!, for: .normal)
        }
        else if btnType == 2
        {
          
            self.btnGender.setTitle(ViewBorder.shareViewBorder.arrGender[row], for: .normal)
        }
        else if btnType == 3
        {
            self.btnAgeGroup.setTitle(ViewBorder.shareViewBorder.arrAge[row], for: .normal)
        }
        else if btnType == 4
        {
            let objState = ViewBorder.shareViewBorder.arrState[row]
            self.stateName = objState.state
            self.btnState.setTitle(objState.state, for: .normal)
        }
        else if btnType == 5
        {
            let objLocalGoverment =  self.arrlocalGoverMent[row]
            self.strLocalGovermentName =  objLocalGoverment.lganame!
            self.strLocalGoverMentCode = objLocalGoverment.lgacode!
            self.btnLocalGoverment.setTitle(objLocalGoverment.lganame!, for: .normal)
        }
        
        else if btnType == 6
        {
            let objWard =  self.arrWard[row]
            self.strWardName =  objWard.WardName!
            self.strWardCode = objWard.WardCode!
            self.btnWard.setTitle(objWard.WardName!, for: .normal)
        }
        
    }
    
    //MARK: -  UIView Animation Methods
    
    func showAnimation()
    {
        if let window =  UIApplication.shared.keyWindow
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.viewPickerSuper.frame = CGRect(x: 0, y: (window.frame.size.height -  self.viewPickerSuper.frame.size.height) , width: window.frame.size.width, height:  self.viewPickerSuper.frame.size.height)
            })
        }
    }
    
    func hideAnimation()
    {
        if let window =  UIApplication.shared.keyWindow
        {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.viewPickerSuper.frame = CGRect(x: 0, y: window.frame.size.height , width: window.frame.size.width, height: self.viewPickerSuper.frame.size.height)
            })
        }
    }
    
    //MARK: API Call
    
    func getGovermentAndWard()
    {
       
        
        let postString = "statename=\(self.stateName)"
        
        ApiService().callApiPost(strAction: WebServiceConstans.LocalGoverment, strWebType: "POST", paramsString: postString) { (dict) in
            
            let dictTemp:NSMutableDictionary = dict as! NSMutableDictionary
            
            let arrLocalGovermentTemp = dictTemp.object(forKey: "nglga_data") as! NSArray
            
            for(_,dict) in arrLocalGovermentTemp.enumerated()
            {
                let dictTemp :NSMutableDictionary =  dict as! NSMutableDictionary
                let objLocalGoverment =  LocalGoverment()
                objLocalGoverment.id  = dictTemp.object(forKey: "id") as! String
                objLocalGoverment.statename  = dictTemp.object(forKey: "statename") as! String
                objLocalGoverment.lganame  = dictTemp.object(forKey: "lganame") as! String
                objLocalGoverment.statecode  = dictTemp.object(forKey: "statecode") as! String
                objLocalGoverment.lgacode  = dictTemp.object(forKey: "lgacode") as! String
                
                self.arrlocalGoverMent.append(objLocalGoverment)
                
            }
            let objLoclgoverMent =  self.arrlocalGoverMent[0]
            self.strLocalGovermentName = objLoclgoverMent.lganame!
            self.strLocalGoverMentCode = objLoclgoverMent.lgacode!
            
            self.btnLocalGoverment.setTitle(objLoclgoverMent.lganame, for: .normal)
            
            let strWardParam = "LGACode=\(objLoclgoverMent.lgacode!)"
            print(strWardParam)
            ApiService().callApiPost(strAction: WebServiceConstans.Ward, strWebType: "", paramsString: strWardParam, complition: { (dict) in
                
                let dictTemp:NSMutableDictionary = dict as! NSMutableDictionary
                
                let arrWardTemp = dictTemp.object(forKey: "nglga_data") as! NSArray
                
                for(_,dict) in arrWardTemp.enumerated()
                {
                    let dictTemp :NSMutableDictionary =  dict as! NSMutableDictionary
                    let objWard =  Ward()
                    objWard.id  = dictTemp.object(forKey: "id") as! String
                    objWard.WardName  = dictTemp.object(forKey: "WardName") as! String
                    objWard.StateCode  = dictTemp.object(forKey: "StateCode") as! String
                    objWard.LGACode  = dictTemp.object(forKey: "LGACode") as! String
                    objWard.WardCode  = dictTemp.object(forKey: "WardCode") as! String
                    self.arrWard.append(objWard)
                    
                }
                let objWard =  self.arrWard[0]
                self.strWardName = objWard.WardName
                self.strWardCode = objWard.WardCode
                self.btnWard.setTitle(objWard.WardName, for: .normal)
                
            })
            
        }
        
    }
    
    func sendRegistrationParam()
    {
       
//        {
//            response = "email already registered try with other";
//        }

        
        print(self.btnTitle.titleLabel?.text ?? "")
        
        let postString = "title=\(self.btnTitle.titleLabel?.text ?? "")&firstname=\(self.txtFirstName.text!)&surname=\(self.txtLastName.text!)&middlename=\(self.txtMiddleName.text!)&email=\(self.txtEmailAddress.text!)&phoneno=\(self.txtPhoneNumber.text!)&intro=\("")&gender=\(self.btnGender.titleLabel?.text ?? "")&address1=\(self.txtAddressLineOne.text!)&address2=\(self.txtAddressLineTwo.text!)&town=\(self.txtCity.text!)&state=\(self.btnState.titleLabel?.text ?? "")&acctno=\("")&agegroup=\(self.btnAgeGroup.titleLabel?.text ?? "")&lga=\(self.btnLocalGoverment.titleLabel?.text ?? "")&aka=\("")&password=\(self.txtPassword.text!)&state_code=\(self.stateCode)&lga_code=\(self.stateCode)&ward_code=\(self.strWardCode!)&ward=\(self.strWardName!)"
        
        print(postString)
        ActivityController().showActivityIndicator(uiView: self.view)
        ApiService().callApiPost(strAction: WebServiceConstans.ProfileJoinUs, strWebType: "", paramsString: postString) { (dict) in
            print(dict)
            ActivityController().hideActivityIndicator(uiView: self.view)
        }
        
        
      /*  "title"
                    , "firstname", "surname", "middlename", "email"
                    , "phoneno", "intro","gender"
                    ,"address1", "address2"
                    , "town", "state"
                    ,"acctno", "agegroup"
                    ,"lga","aka","password","state_code","lga_code","ward_code", "ward"*/

        
        
    }
    
    //MARK: UIAleart View Actions
    
    func showAleart(strTitle:String, strMessage:String)
    {
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            
            
        }))

        self.present(alert, animated: true)

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
