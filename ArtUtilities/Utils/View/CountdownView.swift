//
//  CountdownView.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 8/29/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

@IBDesignable open class CountdownView: UIView {
    
    var offset: CGFloat {
        return 0
    }
    
    var width: CGFloat {
        return self.bounds.width
    }
    var height: CGFloat {
        return self.bounds.height - (offset * 2)
    }
    
    var countOffset: CGFloat {
        return offset + countHeight - unitHeight / 2
    }
    var countHeight: CGFloat {
        return height * (3/4)
    }
    var unitHeight: CGFloat {
        return height - countHeight
    }
    
    lazy var countLabel: UILabel = {
        var label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: offset), size: CGSize.init(width: width, height: countHeight)))
        label.font = UIFont.boldSystemFont(ofSize: countHeight * 1)
        label.textAlignment = .center
        label.clipsToBounds = false
        return label
    }()
    
    lazy var unitLabel: UILabel = {
        var label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: countOffset), size: CGSize.init(width: width, height: unitHeight * 3/2)))
        label.font = UIFont.systemFont(ofSize: unitHeight * 1, weight: UIFont.Weight.black)
        label.textAlignment = .center
        return label
    }()
    
    public var unit: String = "Minutes" {
        didSet {
            unitLabel.text = unit
        }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.white {
        didSet {
            countLabel.textColor = textColor
            unitLabel.textColor = textColor
        }
    }
    
    public var value: Double = 0 {
        didSet {
            if abs(value) < 60 {
                countLabel.text = "\(Int(value))"
                unit = "Minutes"
            } else if abs(value) < 60 * 24 {
                countLabel.text = "\(Int(value / 60))"
                unit = "Heures"
            } else if abs(value) < 60 * 24 * 30 {
                countLabel.text = "\(Int(value / (60 * 24)))"
                unit = "Jours"
            } else {
                countLabel.text = "\(Int(value / (60 * 24 * 30)))"
                unit = "Mois"
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        unitLabel.frame = CGRect.init(origin: CGPoint.init(x: 0, y: countOffset), size: CGSize.init(width: width, height: unitHeight))
        countLabel.frame = CGRect.init(origin: CGPoint.init(x: 0, y: offset), size: CGSize.init(width: width, height: countHeight))
        unitLabel.font = UIFont.boldSystemFont(ofSize: unitHeight * 0.7)
        countLabel.font = UIFont.boldSystemFont(ofSize: countHeight * 0.5)
    }
    
    func setUp() {
        self.addSubview(countLabel)
        self.addSubview(unitLabel)
        self.clipsToBounds = false
        
        unitLabel.text = unit
        countLabel.textColor = textColor
        unitLabel.textColor = textColor
    }
}
