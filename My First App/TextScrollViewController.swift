//
//  TenthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 21.03.2024.
//

import UIKit

class TextScrollViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    static func create(text: String) -> TextScrollViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardIDs.textscroll) as! TextScrollViewController
        vc.text = text
        return vc
    }
    
    var text: String = ""
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = text
        
        if textLabel.text == "Последний рубеж - вы хотите попасть в Apple Store?" {
            nextButton.isHidden = false
        }
    }
    
    @IBAction func nextButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc11 = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.applestore) as! UITabBarController
        self.navigationController?.pushViewController(vc11, animated: true) // переход с использованием первого Navigation Controller
    }
    
}

