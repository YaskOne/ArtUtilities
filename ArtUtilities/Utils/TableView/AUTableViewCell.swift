//
//  AUTableViewCell.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 9/18/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit

public protocol AUCellSelectedDelegate {
    func cellSelected(cell: AUTableViewCell)
}

open class AUTableViewCell: UITableViewCell {
    
    open var cellSelected: Bool = false {
        didSet {
            updateCellSelection()
        }
    }
    
    public var delegate: AUCellSelectedDelegate?
    
    public func setUp() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cellTapped)))
    }
    
    @objc func cellTapped() {
        delegate?.cellSelected(cell: self)
        cellSelected = true
    }
    
    open func updateCellSelection() {
        UIView.animate(withDuration: 0.35) {
            self.backgroundColor = self.cellSelected ? UIColor.gray : UIColor.white
        }
    }
}
