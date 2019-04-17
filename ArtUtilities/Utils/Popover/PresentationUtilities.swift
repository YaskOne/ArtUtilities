//
//  PresentationUtilities.swift
//  Jack
//
//  Created by Arthur Ngo Van on 16/06/2018.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

import UIKit

public enum APresentationDirection: Int {
    case left
    case top
    case right
    case bottom
}

open class APresentationController: UIPresentationController {
    
    public var direction = APresentationDirection.left
    
    public var sizeRatio: CGFloat = 0.5
    public var sizePt: CGFloat = 0
    
    public var offsetRatio: CGFloat {
        return 1 - sizeRatio
    }
    
    lazy var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        background.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        background.isUserInteractionEnabled = true
        background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismiss)))
        return background
    }()
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: APresentationDirection,
         sizeRatio: CGFloat?,
         sizePt: CGFloat) {
        self.direction = direction
        if let sizeRatio = sizeRatio {
            self.sizeRatio = sizeRatio
        }
        self.sizePt = sizePt
        
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
    }
    
    @objc func dismiss(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    open override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: sizePt != 0 ? sizePt : parentSize.width * sizeRatio, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: sizePt != 0 ? sizePt : parentSize.height * sizeRatio)
        }
    }
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        switch direction {
        case .right:
            frame.origin.x = sizePt != 0 ? containerView!.frame.width - sizePt : containerView!.frame.width * offsetRatio
        case .bottom:
            frame.origin.y = sizePt != 0 ? containerView!.frame.height - sizePt : containerView!.frame.height * offsetRatio
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    open override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.backgroundView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.backgroundView.removeFromSuperview()
        })
    }
    
    open override func presentationTransitionWillBegin() {
        self.backgroundView.alpha = 0
        self.containerView?.addSubview(backgroundView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.backgroundView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            
        })
    }
    
    open override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
    }
    
    open override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        backgroundView.frame = containerView!.bounds
    }
}

open class APresentableViewController: UIViewController {
    open var direction: APresentationDirection {
        return .bottom
    }
    open var sizeRatio: CGFloat {
        return 0.5
    }
    open var sizePt: CGFloat {
        return 0
    }
}

public protocol AViewControllerTransitioningDelegate: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: APresentableViewController?, source: UIViewController) -> UIPresentationController?
    func animationController(forPresented presented: UIViewController,
                             presenting: APresentableViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    func animationController(forDismissed dismissed: APresentableViewController)
        -> UIViewControllerAnimatedTransitioning?
}

open class APresenterViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presenting = presented as? APresentableViewController
        return APresentationController(presentedViewController: presented, presenting: presenting, direction: presenting?.direction ?? .bottom, sizeRatio: presenting?.sizeRatio, sizePt: presenting?.sizePt ?? 0)
    }
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AUPresentationAnimator(direction: (presenting as? APresentableViewController)?.direction ?? .bottom, isPresentation: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return AUPresentationAnimator(direction: (dismissed as? APresentableViewController)?.direction ?? .bottom, isPresentation: false)
    }
    
}
