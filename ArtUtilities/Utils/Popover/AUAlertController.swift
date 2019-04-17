//
//  AUAlert.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/4/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

public struct AlertAction {
    var title: String
    var color: UIColor
    var style: UIAlertActionStyle
    var callback: () -> Void = {}
    
    public init(title: String, color: UIColor = UIColor.gray, style: UIAlertActionStyle = .default, callback: @escaping () -> Void = {}) {
        self.title = title
        self.callback = callback
        self.color = color
        self.style = style
    }
}

open class AUAlertController: UIAlertController {
    
    static public let shared: AUAlertController = AUAlertController()
    
    var defaultOk: String?
    var defaultCancel: String?
    
    public func setUpDefault(defaultOk: String, defaultCancel: String) {
        self.defaultOk = AULocalized.string(defaultOk)
        self.defaultCancel = AULocalized.string(defaultCancel)
    }
    
    public func simpleAlertController(
        _ controller: UIViewController,
        title: String? = nil,
        message: String? = nil,
        ok: String? = nil,
        cancel: String? = nil,
        preferredStyle: UIAlertControllerStyle = .alert,
        success: @escaping () -> Void,
        error: @escaping () -> Void
        ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: ok ?? defaultOk, style: .default, handler: { action in
            success()
        }))
        alert.addAction(UIAlertAction(title: cancel ?? defaultCancel, style: .default, handler: { action in
            error()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    public func complexAlertController(
        _ controller: UIViewController,
        title: String? = nil,
        message: String? = nil,
        actions: [AlertAction],
        preferredStyle: UIAlertControllerStyle = .alert
        ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.callback()
            }))
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
}

