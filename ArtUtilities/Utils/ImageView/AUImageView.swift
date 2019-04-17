//
//  AUImageView.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

@IBDesignable open class AUImageView: UIImageView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var cornerRadiusRatio: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderWidthRatio: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override var frame: CGRect {
        didSet {
            setUp()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius != 0 ? cornerRadius : cornerRadiusRatio * frame.height
        layer.borderWidth = borderWidth != 0 ? borderWidth : borderWidthRatio * frame.height
        layer.borderColor = borderColor.cgColor
    }
    
    var baseImage: UIImage? = UIImage.init(named: "logo_black_and_white")
    
    open override var image: UIImage? {
        didSet {
            self.contentMode = image == baseImage ? UIViewContentMode.scaleAspectFit : UIViewContentMode.scaleAspectFill
        }
    }
    
    public func setUp() {
        self.clipsToBounds = true
        
        if image == nil {
            image = baseImage
        }
        
        setNeedsLayout()
    }
}
