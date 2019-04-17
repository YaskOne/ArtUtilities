//
//  AUViewController.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

open class AUViewController: UIViewController {
    
    public var offsetView: UIView?
    
    var offset: CGFloat {
        if let offsetView = offsetView {
            return view.frame.height - (offsetView.frame.origin.y + offsetView.frame.height)
        } else {
            return 0
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        initKeyboardEvents()
    }

    func initKeyboardEvents() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc override public func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
//                print("KEYBORD")
//                print(keyboardSize.height)
//                print("offest")
//                print(self.offset)
                self.view.frame.origin.y = -keyboardSize.height + self.offset - 30
            }
        }
    }

}
