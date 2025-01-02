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
    
    private func showVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizDescriptionID")
        self.present(vc, animated: true)
    }
    
    @IBAction private func themeButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @IBAction private func themeButtonTouchedUpInside(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            QuizFactory.shared.loadTheme(&QuizFactory.shared.chosenTheme, themeName: "music")
        case 2:
            QuizFactory.shared.loadTheme(&QuizFactory.shared.chosenTheme, themeName: "tech")
        case 3:
            QuizFactory.shared.loadTheme(&QuizFactory.shared.chosenTheme, themeName: "history")
        case 4:
            QuizFactory.shared.loadTheme(&QuizFactory.shared.chosenTheme, themeName: "politics")
        default:
            break
        }
        QuizFactory.shared.resetProgress()
        showVC()
    }
    
    @IBAction private func themeButtonTouchedUpOutside(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
    @IBAction private func backButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Navigation")
        self.present(vc, animated: true)
    }
    
    
}
