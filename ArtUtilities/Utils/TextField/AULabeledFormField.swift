//
//  AULabeledFormField.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

public typealias FormFieldValidator = () -> FormStatus

open class AUFormLabeledField: AULabeledTextField {
    
    /*
        Public class variables
    */

    public var mandatory: Bool = true
    
    public private(set) var formStatus: FormStatus = .none {
        didSet {
            UIView.animate(withDuration: 0.35, animations: {
                self.updateFieldState()
            })
        }
    }
    
    override open var text: String? {
        didSet {
            checkFieldStatus()
        }
    }
    
    /*
        Class variables
     */
    
    private var validator: FormFieldValidator?
    
    /*
        Hint values
    */

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
    
    var hintFrame: CGRect {
        let frame = labelFrame
        
        return formStatus == .none ? CGRect.zero : CGRect.init(origin: CGPoint.init(x: frame.origin.x - frame.height, y: frame.origin.y), size: CGSize.init(width: frame.height, height: frame.height))
    }
    
    // final label frame
    override var labelFrame: CGRect {
        let frame = selectedState ? selectedFrame : defaultFrame
        
        return formStatus == .none ? frame : frame.offsetBy(dx: frame.height * 5 / 4, dy: 0)
    }
    
    lazy var hint: UILabel = {
        var label = UILabel()
        
        label.font = UIFont(name: "jackfont", size: defaultFrame.height)
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        
        return label
    }()
    
    override func updateFieldState() {
        super.updateFieldState()

        self.hint.text = self.hintTexts[self.formStatus]
        self.hint.textColor = self.hintColors[self.formStatus]
        self.hint.frame = self.hintFrame
        self.hint.font = UIFont(name: "jackfont", size: hintFrame.height)
    }
    
    @objc public func checkFieldStatus() {
        if let validator = validator {
            formStatus = validator()
        }
    }

    /*
        Intitializers
    */
    
    override func setUp() {
        super.setUp()
        
        self.addSubview(hint)
        updateFieldState()
    }
    
    public func initialize(mandatory: Bool = true, validator: FormFieldValidator? = nil) {
        self.validator = validator
        self.mandatory = mandatory
        
        self.addTarget(self, action: #selector(checkFieldStatus), for: .editingChanged)
    }
}
