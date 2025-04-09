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
            let vc6 = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.cookieclicker) as! CookieClickerViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        let cookieResultAction = UIAction(title: "Cookie Results") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.cookieresults) as! CookieResultsViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        
        let cookieMenu = UIMenu(title: "Выбрать экран", children: [cookieClickerAction, cookieResultAction])
        cookieClickerButton.menu = cookieMenu
        
        let contactsAction = UIAction(title: "Контакты 1.0") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.contacts)
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        let contacts2Action = UIAction(title: "Контакты 2.0") { _ in
            let vc6 = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.contacts2)
            self.navigationController?.pushViewController(vc6, animated: true)
        }
        
        let contactsMenu = UIMenu(title: "Выбрать версию", children: [contactsAction, contacts2Action])
        contactsButton.menu = contactsMenu
        contactsButton.showsMenuAsPrimaryAction = true
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let viewControllers: [Int: String] = [
                1: StoryboardIDs.iqtest,
                2: StoryboardIDs.soundsettings,
                3: StoryboardIDs.photoshop,
                4: StoryboardIDs.cookieclicker,
                7: StoryboardIDs.icemusic,
                8: StoryboardIDs.applestore,
                10:StoryboardIDs.lifedays,
                11:StoryboardIDs.namescomp,
                12:StoryboardIDs.reminders,
                13:StoryboardIDs.dice,
                14:StoryboardIDs.typingtest,
                15:StoryboardIDs.quizice
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
