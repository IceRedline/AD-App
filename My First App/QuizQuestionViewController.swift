//
//  QuizQuestionViewController.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import UIKit

var questionCount = 1
var chosenAnswer = ""
var timer: Timer!
var progress: Float = 1.0

class QuizQuestionViewController: UIViewController {

    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var timerBar: UIProgressView!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        themeName.text = chosenTheme.name
        answer1.setTitle(chosenTheme.answers[0], for: .normal)
        answer2.setTitle(chosenTheme.answers[1], for: .normal)
        answer3.setTitle(chosenTheme.answers[2], for: .normal)
        answer4.setTitle(chosenTheme.answers[3], for: .normal)
        
        question.text = chosenTheme.questions.keys.first
        questionNumber.text = "Вопрос №\(questionCount)"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
            // Обновляем значение progress и проверяем завершение
            if progress > 0 {
                progress -= 0.01
                timerBar.progress = progress
            } else {
                timer.invalidate()
                answer1.isEnabled = false
                answer2.isEnabled = false
                answer3.isEnabled = false
                answer4.isEnabled = false
            }
        }
    
    func checkAnswer(_ answer: String) -> Bool {
        if answer == chosenTheme.questions[chosenTheme.questions.keys.first!] {
            return true
        }
        return false
    }
    
    
    @IBAction func answer1Chosen() {
        chosenAnswer = answer1.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
    }
    
    @IBAction func answer2Chosen() {
        chosenAnswer = answer2.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
    }
    
    @IBAction func answer3Chosen() {
        chosenAnswer = answer3.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
    }
    
    @IBAction func answer4Chosen() {
        chosenAnswer = answer4.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
    }
    
}

