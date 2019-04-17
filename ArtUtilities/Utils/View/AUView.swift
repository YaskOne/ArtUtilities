//
//  AUView.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

@IBDesignable open class AUView: UIView {
    
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
    
    @IBInspectable public var borderWidthRatio: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidthRatio * frame.height
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var blured: Bool = false {
        didSet {
            if blured {
                blur()
            }
            else {
                unblur()
            }
        }
    }
    
    var blurView: UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    open func setUp() {
        self.clipsToBounds = false
    }
}
