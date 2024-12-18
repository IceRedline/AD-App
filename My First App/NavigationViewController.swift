//
//  NavigationViewController.swift
//  My First App
//
//  Created by Артем Табенский on 18.12.2024.
//

import UIKit

class NavigationViewController: UIViewController {

    @IBOutlet weak var cookieClickerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cookieClickerAction = UIAction(title: "Cookie Clicker") { _ in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc6 = storyboard.instantiateViewController(withIdentifier: "cookieClicker") as! CookieClickerViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        let cookieResultAction = UIAction(title: "Cookie Results") { _ in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc6 = storyboard.instantiateViewController(withIdentifier: "six") as! CookieResultsViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        
        let cookieMenu = UIMenu(title: "Cookie menu", children: [cookieClickerAction, cookieResultAction])
        cookieClickerButton.menu = cookieMenu
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc6 = storyboard.instantiateViewController(withIdentifier: "cookieClicker") as! CookieClickerViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        default: return
        }
    }
    
}
