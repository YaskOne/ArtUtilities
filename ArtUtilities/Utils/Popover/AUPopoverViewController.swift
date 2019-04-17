//
//  APopoverViewController.swift
//  Jack
//
//  Created by Arthur Ngo Van on 19/04/2018.
//  Copyright © 2018 Tristan Leblanc. All rights reserved.
//

import UIKit

public class AUPopoverViewController: UIViewController {
    
    // sets x margins according to ratio
    var xMarginRatio: CGFloat = 0.1 {
        didSet {
            setUp()
        }
    }
    
    // sets y margins according to ratio
    var yMarginRatio: CGFloat = 0.1 {
        didSet {
            setUp()
        }
    }
    
    // sets controller overall ratio
    public var popoverRatio: CGFloat = 0 {
        didSet {
            setUp()
        }
    }
    
    var xMargin: CGFloat {
        return self.view.frame.width * xMarginRatio
    }
    var yMargin: CGFloat {
        return popoverRatio == 0 ? self.view.frame.height * yMarginRatio : (view.frame.height - (view.frame.width * 1/popoverRatio)) / 2
    }
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 21
        container.isUserInteractionEnabled = true
        return container
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backgroundTapped), for: .touchUpInside)
        button.frame = self.view.frame
        return button
    }()
    
    lazy var blurView: UIView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        return blurEffectView
    }()
    
    var currentController: UIViewController? {
        didSet {
            if let oldValue = oldValue {
                removeViewController(oldValue)
            }
            if let currentController = currentController {
                addViewController(currentController, inView: containerView)
            }
        }
    }
    
    public func setUp(view: UIView, frame: CGRect, controller: UIViewController) {
        // set the presentation style
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        // set up the popover presentation controller
        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = frame
        self.modalTransitionStyle = .crossDissolve
        
        self.currentController = controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(blurView)
        view.addSubview(backButton)
        view.addSubview(containerView)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUp()
        
        UIView.animate(withDuration: 0.35) {
            self.blurView.alpha = 1
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    func setUp() {
        containerView.removeConstraints(view.constraints)
        
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -xMargin))
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: xMargin))
        
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -yMargin))
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: yMargin))
        self.view.layoutIfNeeded()
        containerView.backgroundColor = currentController?.view.backgroundColor
        
        var containerFrame = containerView.frame
        containerFrame.origin = CGPoint.zero
        currentController?.view.frame = containerFrame.insetBy(dx: 15, dy: 15)
    }
    
    @objc func backgroundTapped() {
        dismiss(animated: true)
    }
}
