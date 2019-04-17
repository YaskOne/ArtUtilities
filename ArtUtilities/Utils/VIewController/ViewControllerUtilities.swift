//
//  ViewControllerUtilities.swift
//  Jack
//
//  Created by Arthur Ngo Van on 11/06/2018.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func addViewController(_ viewController: UIViewController, inView: UIView? = nil) {
        guard let targetView = inView ?? self.view else { return }
        targetView.addSubview(viewController.view)
        viewController.view.frame = targetView.bounds
        viewController.view.autoresizesSubviews = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.willMove(toParentViewController: self)
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    public func removeViewController(_ viewController: UIViewController?) {
        guard let vc = viewController else { return }
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
        vc.didMove(toParentViewController: nil)
    }
    
}

public extension UIViewController {
    
    func handleKeyboardVisibility() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func handleKeyboardOffset() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
//        }
    }
}

public extension UINavigationController {
    
    public func replaceCurrentViewController(with viewController: UIViewController, animated: Bool) {
        pushViewController(viewController, animated: animated)
        let indexToRemove = viewControllers.count - 2
        if indexToRemove >= 0 {
            viewControllers.remove(at: indexToRemove)
        }
    }
    
}
