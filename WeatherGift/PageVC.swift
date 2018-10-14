//
//  PageVC.swift
//  WeatherGift
//
//  Created by Paige Carey on 10/10/18.
//  Copyright © 2018 Paige Carey. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var currentPage = 0
    var locationsArray = ["Local City", "Sydney, Australia", "Accra, Greece", "Uglich, Russia"]
    var pageControl: UIPageControl!
    var listButton: UIButton!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configurePageController()
        configureListButton()
    }
    
    
    //MARK:- UI Configuration Methods
    func configurePageController() {
        let pageControlHeight: CGFloat = barButtonHeight
        let pageControlWidght: CGFloat = view.frame.width - (barButtonWidth * 2)
        
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        pageControl = UIPageControl(frame: CGRect(x: (view.frame.width - pageControlWidght) / 2, y: safeHeight - pageControlHeight, width: pageControlWidght, height: pageControlHeight))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        
        view.addSubview(pageControl)
        
    }
    
    func configureListButton() {
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        listButton = UIButton(frame: CGRect(x: view.frame.width - barButtonWidth, y: safeHeight - barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setImage(UIImage(named: "listbutton"), for: .normal)
        listButton.setImage(UIImage(named: "listbutton-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueToLocationVC), for: .touchUpInside)
        view.addSubview(listButton)
    }
    
    @objc func segueToLocationVC() {
        print("hey you clicked me!")
        
    }
    
    
    //MARK:- Create View Controller for UIPageViewController
    func createDetailVC(forPage page: Int) -> DetailVC {
        
       currentPage = min(max(0, page), locationsArray.count-1)
        
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage 
        
        return detailVC
    }
    
}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage < locationsArray.count-1 {
                return createDetailVC(forPage: currentPage + 1)
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage > 0 {
                return createDetailVC(forPage: currentPage - 1)
            }
    }
    return  nil
}
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? DetailVC {
            pageControl.currentPage = currentViewController.currentPage
            
    }
    }

    
    @objc func pageControlPressed() {
        guard let currentViewController = self.viewControllers?[0] as? DetailVC else {return}
        
        currentPage = currentViewController.currentPage
        if pageControl.currentPage < currentPage {
            setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .reverse, animated: true, completion: nil)
        } else if pageControl.currentPage > currentPage {
            setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

