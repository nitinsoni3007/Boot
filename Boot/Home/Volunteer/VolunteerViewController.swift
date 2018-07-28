//
//  VolunteerViewController.swift
//  Boot
//
//  Created by Nitin on 23/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit
import MobileCoreServices

enum PickerType {
    case title
    case volunteeringField
    case state
    case localGovt
    case ward
}

class VolunteerViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    

    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnVolunteeringField: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnLocalGov: UIButton!
    @IBOutlet weak var btnWard: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var lblUploadedFilename: UILabel!
    @IBOutlet weak var btnDeleteFile: UIButton!
    @IBOutlet weak var pickerCommon: UIPickerView!
    @IBOutlet weak var viewPickerSuper: UIView!
//    var arrTitles = ["Mr", "Ms", "Mrs"]
    var arrPickerData = [String](){
        didSet {
            pickerCommon.reloadAllComponents()
        }
    }
    var currentPickerType = PickerType.title
    var selectedState: State?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        svMain.delegate = self
        self.viewPickerSuper.frame = CGRect(x: 0, y: view.bounds.height , width: self.view.frame.size.width, height:  self.viewPickerSuper.frame.size.height)
        self.view.bringSubview(toFront: viewPickerSuper)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollviewTouched))
        svMain.addGestureRecognizer(tapGesture)
        svMain.contentSize = CGSize(width: svMain.bounds.width, height: 1250)
    }
    
    
    
    @objc func scrollviewTouched() {
        view.endEditing(true)
        hideAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        svMain.removeGestureRecognizer(svMain.gestureRecognizers![0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTitleAction(_ sender: Any) {
        currentPickerType = .title
        arrPickerData = ViewBorder.shareViewBorder.arrTitle.map({$0.titlename!})
        slideToTapped((sender as! UIButton))
    }
    
    @IBAction func btnVolunteeringFieldAction(_ sender: Any) {
        currentPickerType = .volunteeringField
        arrPickerData = ViewBorder.shareViewBorder.arrVolunteerFields.map({$0.vfieldname!})
        slideToTapped((sender as! UIButton))
    }
    
    @IBAction func btnStateAction(_ sender: Any) {
        currentPickerType = .state
        arrPickerData = ViewBorder.shareViewBorder.arrState.map({$0.state})
        slideToTapped((sender as! UIButton))
    }
    
    @IBAction func btnLocalGovAction(_ sender: Any) {
//        currentPickerType = .localGovt
//        slideToTapped((sender as! UIButton))
    }
    
    @IBAction func btnWardAction(_ sender: Any) {
        currentPickerType = .ward
        arrPickerData = arrWard.map({$0.WardName!})
        slideToTapped((sender as! UIButton))
    }
    
    @IBAction func btnUploadDocumentAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Import from", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.openImagePickerWithOption(sourceType: .camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            self.openImagePickerWithOption(sourceType: .photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Files", style: .default, handler: { (action) in
            let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeTXNTextAndMultimediaData), String(kUTTypeImage)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openImagePickerWithOption(sourceType: UIImagePickerControllerSourceType) {
        let ipController = UIImagePickerController()
        ipController.allowsEditing = false
//        ipController.cameraCaptureMode = .photo
        ipController.sourceType = sourceType
        ipController.delegate = self
        self.present(ipController, animated: false, completion: nil)
    }
    
    @IBAction func btnDeleteFileAction(_ sender: Any) {
        lblUploadedFilename.text = ""
        btnDeleteFile.isHidden = true
    }
    
    @IBAction func btnAgreementAction(_ sender: Any) {
        if areDataValid() && documentUrl != nil {
            ApiService().callMultiPartAPI(strAction: "Volunteer/insert", strWebType: "POST", params: createParamDict(), filePath: documentUrl!.absoluteString) { (resp) in
//                self.showAlert(withMessage: (resp as! [String:String])["response"] ?? "success")
                let alert = UIAlertController(title: nil, message: (resp as! [String:String])["response"] ?? "success", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    
    func createParamDict() -> [String: String] {
        let params = ["title": btnTitle.title(for: .normal)!, "fname":txtFirstName.text!, "lname": txtLastName.text!, "email": txtEmailAddress.text!, "phone": txtPhoneNumber.text!, "state": btnState.title(for: .normal)!, "acctno": "", "volunteerfield": btnVolunteeringField.title(for: .normal)!, "lga": lgaBasedOnState!.lganame, "aka": "", "ward": selectedWard!.WardName, "state_code": selectedState!.StateCode, "lga_cod": lgaBasedOnState!.lgacode, "ward_code": selectedWard!.WardCode]
        
        return params as! [String : String]
    }
    var arrlocalGoverMent = [LocalGoverment]()
    var lgaBasedOnState : LocalGoverment?
    var localGovt : LocalGoverment?
    func fetchLocalGov(withStateName stateName: String) {
            
            
            let postString = "statename=\(stateName)"
            
            ApiService().callApiPost(strAction: webServiceActions.LocalGoverment, strWebType: "POST", paramsString: postString) { (dict) in
                
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
                self.lgaBasedOnState = objLoclgoverMent
//                self.strLocalGovermentName = objLoclgoverMent.lganame!
//                self.strLocalGoverMentCode = objLoclgoverMent.lgacode!
                
                self.btnLocalGov.setTitle(objLoclgoverMent.lganame, for: .normal)
                
                self.localGovt = objLoclgoverMent
                self.fetchWard(withLGovCode: objLoclgoverMent.lgacode!)
                
            }
    }
    
    var arrWard = [Ward]()
    var selectedWard: Ward?
    func fetchWard(withLGovCode lgaCode: String) {
        let strWardParam = "LGACode=\(lgaCode)"
        print(strWardParam)
        
        ApiService().callApiPost(strAction: webServiceActions.Ward, strWebType: "", paramsString: strWardParam, complition: { (dict) in
            
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
            self.selectedWard = objWard
//            self.strWardName = objWard.WardName
//            self.strWardCode = objWard.WardCode
            self.btnWard.setTitle(objWard.WardName, for: .normal)
            
        })
    }
    
    
    @IBAction func btnPickerDoneAction(_ sender: Any) {
        hideAnimation()
        if pickerCommon.numberOfRows(inComponent: 0) > 0 {
        let titleStr = arrPickerData[pickerCommon.selectedRow(inComponent: 0)]
        setTitleOfSelectedView(titleStr: titleStr)
        }
    }
    
    func setTitleOfSelectedView(titleStr: String) {
        switch currentPickerType {
        case .title:
            btnTitle.setTitle(titleStr, for: .normal)
        case .volunteeringField:
            btnVolunteeringField.setTitle(titleStr, for: .normal)
        case .state:
            selectedState = ViewBorder.shareViewBorder.arrState[pickerCommon.selectedRow(inComponent: 0)]
            btnState.setTitle(titleStr, for: .normal)
            fetchLocalGov(withStateName: titleStr)
        case .localGovt:
            btnLocalGov.setTitle(titleStr, for: .normal)
        case .ward:
            btnWard.setTitle(titleStr, for: .normal)
        }
    }
    
    //MARK: image picker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgData = UIImagePNGRepresentation(img)
        let df = DateFormatter()
        df.dateFormat = "yyyyMMddHHmmss"
        let fileName = "\(df.string(from: Date()))" + ".png"
        lblUploadedFilename.text = fileName
        addFileToDD(withData: imgData!, fileName: fileName)
        self.dismiss(animated: true, completion: nil)
    }
    var arrDocumentPicked = [Data]()
    var documentUrl : URL?
    //MARK: Document picker delegate
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myUrl = url as URL
        do {
            let dataToAdd = try Data.init(contentsOf: myUrl)
            self.addFileToDD(withData: dataToAdd, fileName: myUrl.lastPathComponent)
            arrDocumentPicked.append(dataToAdd)
            lblUploadedFilename.text = myUrl.lastPathComponent
            btnDeleteFile.isHidden = false
        }catch {
            print("unable to convert to data")
        }
//        print("import result : \(documentUrl)")
    }
    
    func addFileToDD(withData data: Data, fileName: String) {
        let ddPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = ddPath + "/\(fileName)"
        print("file path = \(filePath)")
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        self.documentUrl = URL.init(fileURLWithPath: filePath)
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -  UIView Animation Methods
    
    func showAnimation(withViewOffset offset: CGFloat)
    {
        
        if let window =  UIApplication.shared.keyWindow
        {
            UIView.animate(withDuration: 0.3, animations: {
                if self.tappedView is UIButton {
                self.viewPickerSuper.frame = CGRect(x: 0, y: (window.frame.size.height -  self.viewPickerSuper.frame.size.height) , width: window.frame.size.width, height:  self.viewPickerSuper.frame.size.height)
                }
                self.oldSVFrame = self.svMain.frame
                self.svMain.frame = CGRect(x: 0, y: -1 * offset, width: self.svMain.bounds.width, height: self.svMain.bounds.height)
            })
        }
    }
    var oldSVFrame : CGRect?
    var tappedView: UIView?
    func hideAnimation()
    {
        if let window =  UIApplication.shared.keyWindow
        {
            UIView.animate(withDuration: 0.3, animations: {
                if self.tappedView is UIButton {
                self.viewPickerSuper.frame = CGRect(x: 0, y: window.frame.size.height , width: window.frame.size.width, height: self.viewPickerSuper.frame.size.height)
                }
                self.svMain.frame = self.oldSVFrame!
            })
        }
    }
    
    func slideToTapped(_ subView: UIView) {
        tappedView = subView
        let viewFrame = view.convert(subView.frame, from: subView.superview)
        let currentOffsetY = viewFrame.origin.y + viewFrame.size.height
        let popoverHeight = subView is UIButton ? viewPickerSuper.bounds.height : 252
        let differenceY = (currentOffsetY + popoverHeight) - view.bounds.height - 20
        showAnimation(withViewOffset: differenceY > 0 ? differenceY : 0)
    }
    var showingKeyboard = false
    //MARK: textfield delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showingKeyboard = true
        slideToTapped(textField)
        self.perform(#selector(keyboardDidShown), with: nil, afterDelay: 0.5)
    }
    
    @objc func keyboardDidShown() {
        showingKeyboard = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        hideAnimation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideAnimation()
        return true
    }
    
    func areDataValid() -> Bool {
        var flag = false
        if btnTitle.title(for: .normal)?.isBlank ?? true {
            showAlert(withMessage: "Please choose a title")
            return false
        }
        if let firstName = txtFirstName.text{
            if (firstName.isBlank){
                showAlert(withMessage: "First name should not be blank")
                return false
            }else {
                flag = true
            }
        }
        if let lastName = txtLastName.text{
            if (lastName.isBlank){
                showAlert(withMessage: "Last name should not be blank")
                return false
            }else {
                flag = true
            }
        }
        if btnVolunteeringField.title(for: .normal)?.isBlank ?? true {
            showAlert(withMessage: "Please choose a volunteering field")
            return false
        }
        if btnState.title(for: .normal)?.isBlank ?? true {
            showAlert(withMessage: "Please choose a state")
            return false
        }
        if let phoneNo = txtPhoneNumber.text{
            if (phoneNo.isBlank){
                showAlert(withMessage: "Provide us your phone number")
                return false
            }else if phoneNo.isAlphanumeric {
                flag = true
            }else {
                showAlert(withMessage: "Phone number is not valid")
                return false
            }
        }
        
        if let email = txtEmailAddress.text{
            if (email.isBlank){
                showAlert(withMessage: "Provide us your Email address")
                return false
            }else if email.isEmail {
                flag = true
            }else {
                showAlert(withMessage: "Email address is not valid")
                return false
            }
        }
        return flag
    }
    
    func showAlert(withMessage msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: scrollview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if showingKeyboard == false {
//        view.endEditing(true)
//        }
    }
    
    //MARK: pickerview delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPickerData[row]
    }
}
