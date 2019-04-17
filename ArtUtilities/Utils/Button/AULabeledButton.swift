//
//  AULabeledButton.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/17/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

@IBDesignable open class AULabeledButton: AUButton {
    
    public override func processText() {
        label.text = processedText
        setTitle("", for: .normal)
    }
    
    lazy var label: AULabel = {
        var label = AULabel()
        
        label.numberOfLines = 3
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textAlignment = .center
        
        return label
    }()
    
    override func setUp() {
        super.setUp()
        
        self.addSubview(label)
    }
    
    override func update() {
        super.update()
        
        label.textColor = filled ? defaultTextColor : stateColor
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
}
