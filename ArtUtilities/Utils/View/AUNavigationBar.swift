//
//  AUNavigationBar.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/14/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

open class AUNavigationBar: AUSafeArea {
    
    var iconSize: CGFloat {
        return self.bounds.height / 2
    }
    
    @IBInspectable public var leftIcon: String = "" {
        didSet {
            leftButton.titleLabel?.font = UIFont(name: "jackfont", size: iconSize)
            leftButton.setTitle(leftIcon, for: .normal)
        }
    }
    
    @IBInspectable public var leftText: String = "" {
        didSet {
            leftButton.setTitle(leftText, for: .normal)
            leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    @IBInspectable public var rightIcon: String = "" {
        didSet {
            rightButton.titleLabel?.font = UIFont(name: "jackfont", size: iconSize)
            rightButton.setTitle(rightIcon, for: .normal)
        }
    }
    
    @IBInspectable public var rightText: String = "" {
        didSet {
            rightButton.setTitle(rightText, for: .normal)
            rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    @IBInspectable public var titleText: String = "" {
        didSet {
            label.text = rightText
        }
    }
    
    @IBInspectable var titleColor: UIColor = UIColor.white {
        didSet {
            label.textColor = titleColor
        }
    }
    
    @IBInspectable var leftColor: UIColor = UIColor.white {
        didSet {
            leftButton.setTitleColor(leftColor, for: .normal)
        }
    }
    
    @IBInspectable var rightColor: UIColor = UIColor.white {
        didSet {
            rightButton.setTitleColor(rightColor, for: .normal)
        }
    }
    
    var buttonWidth: CGFloat {
        return self.bounds.height
    }
    
    public var leftAction: (() -> Void) = {
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
    }
    public var rightAction: (() -> Void)?
    
    var offset: CGFloat = 10
    
    public lazy var leftButton: AUButton = {
        let button = AUButton()
        
        button.frame = CGRect(origin: CGPoint.init(x: offset, y: 0), size: CGSize(width: buttonWidth, height: buttonWidth))
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: "jackfont", size: iconSize)
        button.titleLabel?.textAlignment = .center
        button.setTitle(leftIcon, for: .normal)
        
        return button
    }()
    
    public lazy var rightButton: AUButton = {
        let button = AUButton()
        
        button.frame = CGRect(origin: CGPoint.init(x: bounds.width - buttonWidth - offset, y: 0), size: CGSize(width: buttonWidth, height: buttonWidth))
        button.backgroundColor = UIColor.clear
        button.titleLabel?.textAlignment = .center

        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(origin: CGPoint.init(x: offset + buttonWidth, y: 0), size: CGSize(width: frame.width - (offset + buttonWidth) * 2, height: buttonWidth))
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.bold)

        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    override func setUp() {
        super.setUp()
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        
        leftButton.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(leftButtonTapped)))
        rightButton.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(rightButtonTapped)))
    }
    
    @objc func leftButtonTapped() {
        leftAction()
    }
    
    @objc func rightButtonTapped() {
        rightAction?()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        leftButton.frame = CGRect(origin: CGPoint.init(x: offset, y: 0), size: CGSize(width: buttonWidth, height: buttonWidth))
        rightButton.frame = CGRect(origin: CGPoint.init(x: bounds.width - buttonWidth - offset, y: 0), size: CGSize(width: buttonWidth, height: buttonWidth))
        label.frame = CGRect(origin: CGPoint.init(x: offset + buttonWidth, y: 0), size: CGSize(width: frame.width - (offset + buttonWidth) * 2, height: buttonWidth))
    }
    
}
