//
//  bottomTextFieldDelegate.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/21/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import Foundation

import UIKit

class bottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //this delegate code allows for the font to take on certain attributes that look like MEME font
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),  //TODO: Fill in appropriate UIColor,
            NSForegroundColorAttributeName :  UIColor.whiteColor(),   //TODO: Fill in UIColor,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0 //TODO: Fill in appropriate Float
        ]
    
        var bottomTextAttributes = NSAttributedString(string: textField.text, attributes: memeTextAttributes)
        textField.attributedText = bottomTextAttributes
  
        return true
    }
    
    
    
    //this code makes the keyboard disappear once Return is touched
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

}