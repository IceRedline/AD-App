//
//  NavigationViewController.swift
//  My First App
//
//  Created by Артем Табенский on 18.12.2024.
//

import UIKit

class NavigationViewController: UIViewController {

    @IBOutlet private weak var cookieClickerButton: UIButton!
    @IBOutlet private weak var contactsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let cookieClickerAction = UIAction(title: "Cookie Clicker") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: "cookieClicker") as! CookieClickerViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        let cookieResultAction = UIAction(title: "Cookie Results") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: "six") as! CookieResultsViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        
        let cookieMenu = UIMenu(title: "Выбрать экран", children: [cookieClickerAction, cookieResultAction])
        cookieClickerButton.menu = cookieMenu
        
        let contactsAction = UIAction(title: "Контакты 1.0") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: "contacts")
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        let contacts2Action = UIAction(title: "Контакты 2.0") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: "contacts2")
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        
        let contactsMenu = UIMenu(title: "Выбрать версию", children: [contactsAction, contacts2Action])
        contactsButton.menu = contactsMenu
        contactsButton.showsMenuAsPrimaryAction = true
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let viewControllers: [Int: String] = [
                1: "iqtest",
                2: "sound",
                3: "photoshop",
                4: "cookieClicker",
                7: "icemusic",
                8: "PAGESID",
                10: "lifedays",
                11: "names",
                12: "reminders",
                13: "dice",
                14: "typingtest",
                15: "QuizID"
            ]
            
            guard let identifier = viewControllers[sender.tag],
                  let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController else { return }
            
            if sender.tag == 15 {
                self.present(vc, animated: true)
            } else {
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
}
