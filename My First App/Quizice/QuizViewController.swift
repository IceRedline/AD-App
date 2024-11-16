//
//  QuizViewController.swift
//  My First App
//
//  Created by Артем Табенский on 01.10.2024.
//

import UIKit

class QuizViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizDescriptionID")
        self.present(vc, animated: true)
    }
    
    @IBAction func themeChosen(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            chosenTheme = chosenMusicTheme
        case 2:
            chosenTheme = chosenTechTheme
        case 3:
            chosenTheme = chosenHistoryTheme
        case 4:
            chosenTheme = chosenPoliticsTheme
        default:
            break
        }
        showVC()
    }
    
    @IBAction func backButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Navigation")
        self.present(vc, animated: true)
    }
    
    
}
