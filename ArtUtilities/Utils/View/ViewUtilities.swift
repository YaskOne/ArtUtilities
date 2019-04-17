//
//  ViewUtilities.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/6/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit

public extension AUView
{
    public func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        blurView?.frame = self.bounds
        
        blurView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurView!)
    }
    
    public func unblur() {
        blurView?.removeFromSuperview()
    }
    
    public func setUpNib(nibName: String, contentView: UIView, owner: UIView) {
        Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

public extension UIView {
    
    public func displaySpinner() -> UIView {
        let spinnerView = UIView.init(frame: bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    public func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

public extension UIView {
    func findConstraint(layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
//        for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
//            return constraint
//        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutAttribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
}

@IBDesignable open class AUGradientView: UIView {
    
    @IBInspectable public var startColor: UIColor = UIColor.white {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var endColor: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var degreeAngle: Double = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var radianAngle: Double {
        return -(degreeAngle.truncatingRemainder(dividingBy: 360)) * Double.pi / 180
    }
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint.init(x: 0, y: 1)
    }
    
}


public class AUContainerView: UIView {
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if view.point(inside: view.convert(point, from: self), with: event), !view.isHidden, view.alpha > 0 {
                return true
            }
        }
        return false
    }
    
}

@IBDesignable open class AULabel: UILabel {
    
    public var processedText: String? {
        get {
            let text = stringID.isEmpty ? self.text : AULocalized.string(stringID, variables: args)
            return uppercased ? text?.uppercased() : text
        }
    }
    
    @IBInspectable var uppercased: Bool = false {
        didSet {
            text = processedText
        }
    }
    
    @IBInspectable var stringID: String = "" {
        didSet {
            text = processedText
        }
    }
    
    public var args: [String: Any] = [:] {
        didSet {
            text = processedText
        }
    }
    
}
