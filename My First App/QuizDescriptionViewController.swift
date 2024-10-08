//
//  QuizDescriptionViewController.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import UIKit

class QuizDescriptionViewController: UIViewController {
    
    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var themeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeName.text = chosenTheme.name
        themeDescription.text = chosenTheme.description
    }
    
    @IBAction func startButtonTapped() {
        chosenThemeQuestionsArray = Array(chosenTheme.questionsAndAnswers.keys).shuffled()
        questionsToComplete = chosenThemeQuestionsArray.count
        questionCount = 0
        correctAnswers = 0
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizQuestionID")
        self.present(vc, animated: true)
    }
    
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
    }
    
}
