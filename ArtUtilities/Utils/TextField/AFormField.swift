//
//  FormField.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 7/7/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit


public enum FormStatus: Int {
    case none
    case valid
    case invalid
}

open class AFormField {
    
    // fields
    public var input: UIControl? {
        didSet {
        }
    }
    private var label: AFormLabel
    private var defaultValue: Any
    
    public var hintTexts: [FormStatus: String] {
        return [
            .none: "",
            .valid: "",
            .invalid: "",
        ]
    }
    
    public var hintColors: [FormStatus: UIColor] {
        return [
            .none: UIColor.clear,
            .valid: UIColor.green,
            .invalid: UIColor.red,
        ]
    }
    
    public var formStatus: FormStatus = .none {
        didSet {
            label.hint.text = hintTexts[formStatus]
            label.hint.textColor = hintColors[formStatus]
        }
    }
    private var validator: FormFieldValidator?
    
    public var mandatory: Bool

    public init(input: UIControl, label: AFormLabel, defaultValue: Any, mandatory: Bool = true, validator: FormFieldValidator? = nil) {
        self.input = input
        self.label = label
        self.defaultValue = defaultValue
        self.validator = validator
        self.mandatory = mandatory
        
        input.addTarget(self, action: #selector(checkFieldStatus), for: .editingChanged)
    }
    
    @objc public func checkFieldStatus() {
//        if let input = input as? UITextField, input.text == defaultString {
//            formStatus = .none
//        }
//        else if let input = input as? UIDatePicker, input.date == defaultDate {
//            formStatus = .none
//        }
//        else
        if let validator = validator {
            formStatus = validator()
        }
    }
    
}

open class AFormLabel: AULabel {
    
    override open var text: String? {
        didSet {
            update()
        }
    }
    
    lazy var hint: UILabel = {
        var label = UILabel()
        
        label.font = UIFont(name: "jackfont", size: self.bounds.height)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        clipsToBounds = false
        addSubview(hint)
        update()
    }
    
    func update() {
        self.sizeToFit()
        hint.frame = CGRect(origin: CGPoint(x: bounds.width, y: 0), size: CGSize(width: bounds.height, height: bounds.height))
    }
}
