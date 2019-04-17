//
//  ToastUtilities.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/10/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit

open class AUToastController {
    
    public static let shared = AUToastController()
    
//    var toasts = [ToastView]()
//    var color = UIColor.red
//    var fillColor = UIColor.white
//    var baseline: CGFloat = 0
    
    public var container: UIView?
    
    var width: CGFloat = 350
    
    public func toast(text: String, type: ToastType, view: UIView? = nil) {
        
        guard let view = view ?? UIApplication.topViewController()?.view else {
            return
        }
        
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - width/2, y: 100, width: width, height: 45))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 9.0)
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 2
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
//    @objc func dismissToaster(sender: UIButton) {
//        if let toast = sender.superview as? ToastView {
//            removeToast(toast)
//        }
//    }
//
//    func removeToast(_ toast: ToastView) {
//        animateHeight(toast, targetHeight: 0) { toast in
//            DispatchQueue.main.async {
//                toast.removeFromSuperview()
//                if let index = self.toasts.index(of: toast), index < self.toasts.count {
//                    self.toasts.remove(at: index)
//                }
//                self.layoutToasts()
//            }
//        }
//    }
//
//    func animateHeight(_ toast: ToastView, targetHeight: CGFloat, handler: @escaping (ToastView)->Void) {
//        UIView.animate(withDuration: 0.3, animations: {
//            toast.frame.size.height = targetHeight
//            self.layoutToasts()
//        }, completion: { finished in
//            handler(toast)
//        })
//    }
//
//    func layoutToasts() {
//        var offset: CGFloat = 5 + baseline
//        let margin: CGFloat = 5
//        var height: CGFloat = 0
//        for toast in toasts {
//            let h = toast.frame.height
//            toast.frame.origin = CGPoint(x: toast.frame.origin.x, y: offset)
//            offset += h + margin
//            height += h + margin
//        }
//        toastsView?.toastsViewHeight?.constant = toasts.count > 0 ? height + 30 : 3
//    }
}

public enum ToastType {
    case success
    case failure
    case info
    case warning
    case push
    case network
    
//    var iconCharacter: String {
//        switch self {
//        case .success:
//            return JackFont.icon_checkmark_circle
//        case .failure:
//            return JackFont.icon_error
//        case .info:
//            return JackFont.icon_info
//        case .warning:
//            return JackFont.icon_warning
//        case .push:
//            return JackFont.icon_notification
//        case .network:
//            return JackFont.icon_network_error
//        }
//    }
    
    var color: UIColor {
        switch self {
        case .success:
            return UIColor.green.withAlphaComponent(0.5)
        case .failure:
            return UIColor.red.withAlphaComponent(0.5)
        case .info:
            return UIColor.yellow.withAlphaComponent(0.5)
        case .warning:
            return UIColor.orange.withAlphaComponent(0.5)
        case .push:
            return UIColor.blue.withAlphaComponent(0.5)
        case .network:
            return UIColor.gray.withAlphaComponent(0.5)
        }
    }
}

public class ToastView: UIView {
    
    var controller: AUToastController?
    
    @IBOutlet var textLabel:UILabel!
    @IBOutlet var leftLabel:UILabel!
    @IBOutlet var rightButton:UIButton!
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.controller?.removeToast(self)
//    }
}



