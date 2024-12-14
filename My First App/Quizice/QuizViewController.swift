//
//  QuizViewController.swift
//  My First App
//
//  Created by Артем Табенский on 01.10.2024.
//

import UIKit

class QuizViewController: UIViewController {
    
    private let animationsEngine = Animations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizDescriptionID")
        self.present(vc, animated: true)
    }
    
    @IBAction func themeButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @IBAction func themeButtonTouchedUpInside(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            animationsEngine.animateUpFloat(sender)
            chosenTheme = chosenMusicTheme
        case 2:
            animationsEngine.animateUpFloat(sender)
            chosenTheme = chosenTechTheme
        case 3:
            animationsEngine.animateUpFloat(sender)
            chosenTheme = chosenHistoryTheme
        case 4:
            animationsEngine.animateUpFloat(sender)
            chosenTheme = chosenPoliticsTheme
        default:
            break
        }
        showVC()
    }
    
    @IBAction func themeButtonTouchedUpOutside(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
    @IBAction func backButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Navigation")
        self.present(vc, animated: true)
    }
    
    
}
