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
    
    @IBAction func musicThemeChosen() {
        chosenTheme = chosenMusicTheme
        showVC()
    }
    
    @IBAction func techThemeChosen() {
        chosenTheme = chosenTechTheme
        showVC()
    }
    
    @IBAction func historyThemeChosen() {
        chosenTheme = chosenHistoryTheme
        showVC()
    }
    
    @IBAction func politicsThemeChosen() {
        chosenTheme = chosenPoliticsTheme
        showVC()
    }
    
    
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
    }
    
    
}
