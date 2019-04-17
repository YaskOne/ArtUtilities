//
//  TableViewUtils.swift
//  Jack
//
//  Created by Arthur Ngo Van on 17/06/2018.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation
import UIKit

public enum ARowType {
    case header
    case section
    case row
}

open class ATableViewRow {

    public var type: ARowType
    public var section: Int
    public var object: AnyObject?
    
    public init(type: ARowType, section: Int, object: AnyObject? = nil) {
        self.type = type
        self.section = section
        self.object = object
    }
    
}

open class ATableViewSection {
    
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
    
}

public protocol ATableViewScrollDelegate {
    func tableWillScroll()
    func tableDidScroll(offset: CGFloat)
    func tableWillEndDragging(offset: CGFloat, velocity: CGFloat)
}

open class ATableViewController: UITableViewController {
    
    public var lastY: CGFloat = 0.0
    
    open var topInset: CGFloat {
        return 0
    }
    
    public var scrollDelegate: ATableViewScrollDelegate?
    
    open var source: [ATableViewRow] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    open var cellIdentifiers: [ARowType: String] {
        return [:]
    }
    
    open var cellHeights: [ARowType: CGFloat] {
        return [:]
    }
    
    public func itemAtIndex(_ indexPath: IndexPath) -> ATableViewRow {
        return source[indexPath.row]
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bounces = false
        
        for item in cellIdentifiers {
            if !item.value.isEmpty {
                let nib = UINib(nibName: item.value, bundle: nil)
                tableView.register(nib, forCellReuseIdentifier: item.value)
            }
        }
    }
    
    // MARK: - JKTableViewController cells set up

    open func setUpHeader(item: ATableViewRow, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[.header]!, for: indexPath)
    }
    
    open func setUpSection(item: ATableViewRow, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[.section]!, for: indexPath)
    }
    
    open func setUpRow(item: ATableViewRow, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[.row]!, for: indexPath)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: cellHeights[.row] ?? 0, right: 0)
    }
    
}


// MARK: - Table view base set up

extension ATableViewController {
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemAtIndex(indexPath)
        
        switch item.type {
        case .header:
            return setUpHeader(item: item, indexPath: indexPath)
        case .section:
            return setUpSection(item: item, indexPath: indexPath)
        case .row:
            return setUpRow(item: item, indexPath: indexPath)
        }
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[itemAtIndex(indexPath).type] ?? 0
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
}

extension ATableViewController {
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.tableDidScroll(offset: scrollView.contentOffset.y)
    }
    
    open override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollDelegate?.tableWillEndDragging(offset: scrollView.contentOffset.y, velocity: velocity.y)
    }
    
    open override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollDelegate?.tableWillScroll()
    }
}
