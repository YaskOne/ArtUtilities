//
//  AUTextField.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/14/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

open class AUTextField: UITextField {
    
    // uppercases the text
    @IBInspectable public var uppercased: Bool = false {
        didSet {
            setProcessedText()
        }
    }
    
    // stringId contained in dictionary
    @IBInspectable public var stringID: String = "" {
        didSet {
            setProcessedText()
        }
    }
    
    // dynamic arguments
    public var args: [String: Any] = [:] {
        didSet {
            setProcessedText()
        }
    }
    
    // final text to display
    var processedText: String? {
        get {
            let text = stringID.isEmpty ? self.text : AULocalized.string(stringID, variables: args)
            return uppercased ? text?.uppercased() : text
        }
    }
    
    func setProcessedText() {
        text = processedText
    }
    
}
