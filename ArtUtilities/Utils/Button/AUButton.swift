//
//  AUButton.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/2/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

@IBDesignable open class AUButton: UIButton {
    
    @IBInspectable var filled: Bool = false
    @IBInspectable var underlined: Bool = false
    
    @IBInspectable public var defaultTextColor: UIColor = UIColor.white {
        didSet {
            update()
        }
    }
    @IBInspectable public var defaultColor: UIColor = UIColor.black {
        didSet {
            update()
        }
    }
    @IBInspectable public var selectedColor: UIColor = UIColor.blue {
        didSet {
            update()
        }
    }
    
    @IBInspectable public var text: String = "" {
        didSet {
            processText()
        }
    }
    
    public var processedText: String? {
        get {
            let text = stringID.isEmpty ? self.text : AULocalized.string(stringID, variables: args)
            return uppercased ? text.uppercased() : text
        }
    }
    
    @IBInspectable var uppercased: Bool = false {
        didSet {
            processText()
        }
    }
    
    @IBInspectable public var stringID: String = "" {
        didSet {
            processText()
        }
    }
    
    @IBInspectable var iconID: String = "" {
        didSet {
            titleLabel?.font = UIFont(name: "jackfont", size: self.bounds.height)
            titleLabel?.textAlignment = .center
            processText()
        }
    }
    
    public var args: [String: Any] = [:] {
        didSet {
            processText()
        }
    }
    
    public func processText() {
        setTitle(processedText, for: .normal)
    }

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var cornerRadiusRatio: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadiusRatio * frame.height
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        self.clipsToBounds = true
        self.contentMode = UIViewContentMode.scaleAspectFit
        
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius == 0 ? cornerRadiusRatio * frame.height : cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = stateColor.cgColor
        
        setTitleColor(filled ? defaultTextColor : self.stateColor, for: state)
        
        if filled {
            self.backgroundColor = self.stateColor
        }
    }
    
    @IBInspectable var blured: Bool = false {
        didSet {
            if blured {
                blur()
            }
            else {
                unblur()
            }
        }
    }
    
    var stateColor: UIColor {
        return self.isSelected ? self.selectedColor : self.defaultColor
    }
    
    override open var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.35) {
                self.alpha = self.isEnabled ? 1 : 0.6
            }
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.35) {
                self.setUp()
            }
        }
    }
    
    var blurView: UIView?
}

@IBDesignable open class AUSelectableButton: AUButton {

    var underlineHeight: CGFloat = 3
    
    lazy var underline: UIView = {
        var view = UIView()
        
        view.frame = CGRect.init(origin: CGPoint.init(x: 0, y: self.frame.height - underlineHeight), size: CGSize.init(width: self.frame.width, height: underlineHeight))
        view.isHidden = true
        view.backgroundColor = selectedColor
        
        return view
    }()
    
    override func setUp() {
        super.setUp()
        
        self.addSubview(underline)
    }
    
    override open var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.35) {
                self.underline.isHidden = !self.isSelected
            }
        }
    }
    
}
    
public extension AUButton
{
    public func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        blurView?.frame = self.bounds
        blurView?.isUserInteractionEnabled = false
        
        blurView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurView!)
    }
    
    public func unblur() {
        blurView?.removeFromSuperview()
    }
}
