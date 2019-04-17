//
//  AULocalized.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/2/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

open class AULocalized {

    public static func string( _ key: String, comment: String = "", variables: [String:Any]? = nil) -> String {
        var string = NSLocalizedString(key, comment: comment)
        if let vars = variables, vars.count != 0 {
            string = string.replaceVariables(vars)
        }
        return string
    }
    
}

public extension String {
    
    public func replaceVariables(_ array:[String : Any]) -> String {
        var str = self
        for key in array.keys {
            if let value = array[key] {
                let replacement = "\(value)"
                str = str.replacingOccurrences(of: "$\(key)", with: replacement)
            }
        }
        return str
    }
}
