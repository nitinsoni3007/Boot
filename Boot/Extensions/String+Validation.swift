//
//  String+Validation.swift
//  DialMd
//
//  Created by Rupal on 04/04/17.
//  Copyright © 2017 lms. All rights reserved.
//

import Foundation

extension String {
    
    //To check text field or String is blank or not
    
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        let trimmedEmail = self.trimmingCharacters(in: CharacterSet.whitespaces)

        do {
            let regex = try NSRegularExpression(pattern: "^[a-z0-9._]+@[a-z]+\\.[a-z.]{2,20}$", options: .caseInsensitive)
            return regex.firstMatch(in: trimmedEmail, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, trimmedEmail.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        var REGEX = ""
        if self.containsString("+1"){
            REGEX = "^(\\+1)[0-9]{11}$"
        }else
        {
            REGEX = "^[0-9]{11}$"
        }
            let phoneTest = NSPredicate(format: "SELF MATCHES %@",REGEX)
            let result =  phoneTest.evaluate(with: self)
            print(result)
            return result
        }
    
    var ispasswordValid : Bool
    {
        //((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})
// old exprestion
        // "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6}$"
        let REGEX = "^((?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,20})$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",REGEX)
        let result =  passwordCheck.evaluate(with: self)
        print(result)
        return result
    }
    //
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    func containsString(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
        var length: Int {
            return self.characters.count
}
}
