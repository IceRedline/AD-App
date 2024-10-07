//
//  QuizResultViewController.swift
//  My First App
//
//  Created by Артем Табенский on 07.10.2024.
//

import UIKit

class QuizResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = "Твой результат: -/\(questionCount)"
    }
    
    @IBAction func backButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuizID")
        self.present(vc, animated: true)
    }
    
}
