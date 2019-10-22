//
//  Helper.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/26/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height-2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 211/255, green: 84/255, blue: 0/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 208/255, green: 48/255, blue: 15/255, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.white
    }
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red:0.82, green:0.19, blue:0.06, alpha:1.0).cgColor
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.black
    }
}
