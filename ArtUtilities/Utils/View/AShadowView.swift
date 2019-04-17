//
//  AShadowView.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

open class AShadowView: AUView {
    
    public var shadowColor: CGColor = UIColor.black.cgColor {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var shadowOffset: CGSize = CGSize.init(width: 0, height: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var shadowOpacity: Float = 0.6 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var shadowBlurRadius: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowBlurRadius
    }
    
}
