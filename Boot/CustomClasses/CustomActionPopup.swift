//
//  CustomPicker.swift
//  Boot
//
//  Created by Nitin on 23/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit

public enum PopupType {
    case datePicker
}

protocol CustomActionPopupDatePickerDelegate {
    func DatePicked(selectedDate: Date)
}

class CustomActionPopup: UIView {
    
    init(type: PopupType) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        var frameToSet = UIScreen.main.bounds
        var toolBar = UIView(frame: CGRect(x: 0, y: 0, width: frameToSet.width, height: 48))
        toolBar.addRightTools()
        toolBar.addLeftTools()
        self.addSubview(toolBar)
        switch type {
        case .datePicker:
            frameToSet.height = 252 + 48
            
            print("for date picker")

        }
        self.isHidden = true
    }
    
//    func showDatePicker(with selectedDate: Date, minDate: Date, maxDate: Date) {
//
//    }

}

extension UIView {
    
}
