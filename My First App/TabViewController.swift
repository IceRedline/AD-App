//
//  TabViewController.swift
//  My First App
//
//  Created by Артем Табенский on 22.03.2024.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastButton = UIBarButtonItem(title: "Завершение", style: .plain, target: self, action: #selector(pushLastVC))
        self.navigationItem.rightBarButtonItem  = lastButton
    }
    
    @objc func pushLastVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lastVC = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.lastVC)
        self.navigationController?.pushViewController(lastVC, animated: true)
    }
}
