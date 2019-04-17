//
//  AUPageViewController.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 8/23/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import UIKit

public protocol AUPageViewControllerDelegate {
    func pageChanged(index: Int)
}

open class AUPageViewController: UIPageViewController {
    
    public var pages: [UIViewController] = [] {
        didSet {
            setUp()
        }
    }
    
    public var currentIndex: Int = 0 {
        didSet {
            setUp(currentIndex > oldValue ? .forward : .reverse)
        }
    }
    
    public var pageDelegate: AUPageViewControllerDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    public func setUp(_ direction: UIPageViewControllerNavigationDirection = .forward) {
        dataSource = self
        
        if pages.count > 0 {
            setViewControllers([pages[currentIndex]],
                               direction: direction,
                               animated: true,
                               completion: nil)
        }
    }
    
    func indexOfController(_ viewController: UIViewController) -> Int? {
        return pages.index(of: viewController)
    }
    
    public func removeSwipeGesture(){
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}

extension AUPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = indexOfController(viewController), index - 1 >= 0 else {
            return nil
        }
        
        return pages[index - 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = indexOfController(viewController), index + 1 < pages.count else {
            return nil
        }
        
        return pages[index + 1]
    }
    
}
