//
//  AULabeledTextField.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

open class AULabeledTextField: AUTextField {
    
    
    /*
        Public class variables
    */
    
    // Uppercases the text
    @IBInspectable public override var uppercased: Bool {
        didSet {
            setProcessedText()
        }
    }
    
    // StringId contained in dictionary
    @IBInspectable public override var stringID: String {
        didSet {
            setProcessedText()
        }
    }
    
    // Dynamic arguments
    public override var args: [String: Any] {
        didSet {
            setProcessedText()
        }
    }
    
    @IBInspectable var defaultColor: UIColor = UIColor.gray
    @IBInspectable var selectedColor: UIColor = UIColor.blue
    @IBInspectable var labelColor: UIColor = UIColor.gray

    override open var text: String? {
        didSet {
            updateFieldState()
        }
    }
    
    /*
        Private class variables
    */
    
    // Used as label and placeholder
    lazy var label: UILabel = {
        let label = UILabel()

        label.frame = defaultFrame
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.textColor = labelColor
        
        return label
    }()
    
    // Underlining bar
    lazy var bar: UIView = {
        let bar = UIView()
        
        bar.frame = CGRect.init(origin: CGPoint.init(x: 0, y: frame.height - 1), size: CGSize.init(width: frame.width, height: 1))
        bar.backgroundColor = defaultColor
        
        return bar
    }()
    
    // Final text to display
    override var processedText: String? {
        get {
            let text = stringID.isEmpty ? self.label.text : AULocalized.string(stringID, variables: args)
            return uppercased ? text?.uppercased() : text
        }
    }
    
    var fieldSelected: Bool = false {
        didSet {
            if fieldSelected != oldValue {
                UIView.animate(withDuration: 0.35, animations: {
                    self.updateFieldState()
                })
            }
        }
    }
    
    var selectedState: Bool {
        return text != "" || fieldSelected || !isEnabled
    }
    
    /*
        Handle field selection
    */
    
    // Handles label selection
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let res = super.point(inside: point, with: event)
        
        if res {
            fieldSelected = true
        }
        
        return res
    }
    
    // Handles label deselection
    open override func resignFirstResponder() -> Bool {
        fieldSelected = false
        return super.resignFirstResponder()
    }
    
    /*
        Frames processing
    */
    
    var defaultFrame: CGRect {
        return CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: bounds.size)
    }
    var selectedFrame: CGRect {
        return CGRect.init(origin: CGPoint.init(x: 0, y: -bounds.height * 2 / 4), size: CGSize.init(width: bounds.width, height: bounds.height / 2))
    }
    
    var defaultFontHeight: CGFloat {
        return bounds.height / 2
    }
    var selectedFontHeight: CGFloat {
        return bounds.height / 3
    }
    
    // final font height
    var fontHeight: CGFloat {
        return selectedState ? selectedFontHeight : defaultFontHeight
    }

    // final label frame
    var labelFrame: CGRect {
        return selectedState ? selectedFrame : defaultFrame
    }
    
    // final text color
    var processedTextColor: UIColor {
        return (isEnabled && selectedState) ? selectedColor : defaultColor
    }
    
    // Process view
    
    func updateFieldState() {
        self.label.frame = self.labelFrame
        self.textColor = self.processedTextColor
        self.bar.backgroundColor = self.processedTextColor
        self.label.font = self.label.font.withSize(self.fontHeight)
    }
    
    override func setProcessedText() {
        label.text = processedText
    }
    
    /*
        Intitializers
    */
    
    func setUp() {
        self.addSubview(label)
        self.addSubview(bar)
        
        self.borderStyle = .none
        self.clipsToBounds = false
        
        fieldSelected = !isEnabled
        updateFieldState()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        bar.frame = CGRect.init(origin: CGPoint.init(x: 0, y: frame.height - 1), size: CGSize.init(width: frame.width, height: 1))
    }
}
