//
//  AUApplicationUtilities.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/10/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

public extension UIApplication {
    public class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
