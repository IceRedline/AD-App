//
//  PageViewController.swift
//  My First App
//
//  Created by Артем Табенский on 21.03.2024.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    let viewControllerList: [TenthViewController] = [TenthViewController.create(text: "Привет! я текст, который можно скроллить! ->"), TenthViewController.create(text: "При следующем скролле вправо вы принимаете пользовательское соглашение ->"), TenthViewController.create(text: "Последний рубеж - вы хотите попасть в Apple Store?"), ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([viewControllerList.first!], direction: .forward, animated: true)
        
        self.dataSource = self
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(where: {$0 === viewController}), index != 0 {
            return viewControllerList[index - 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(where: {$0 === viewController}), index + 1 < viewControllerList.count {
            return viewControllerList[index + 1]
        }
        return nil
    }
    
}
