//
//  AUNavigationBar.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/14/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

open class AUSafeArea: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        offsetByStatusBar()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.findConstraint(layoutAttribute: .top)?.constant = UIApplication.shared.statusBarFrame.height
    }
    
}

public extension UIView {
    public func offsetByStatusBar() {
        self.findConstraint(layoutAttribute: .top)?.constant = UIApplication.shared.statusBarFrame.height
    }
}
