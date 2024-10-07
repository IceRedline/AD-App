//
//  QuizQuestionViewController.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import UIKit

 // массив с вопросами по выбранной теме
var questionsToComplete = chosenThemeQuestionsArray.count
var questionCount = 0
var currentQuestion = ""
var chosenAnswer = ""

//var timer: Timer!
//var progress: Float = 1.0

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
        currentQuestion = chosenThemeQuestionsArray[0]
        question.text = currentQuestion
        var currentAnswers = chosenTheme.questionsAndAnswers[currentQuestion]!.shuffled()

        let questionButtons = [answer1, answer2, answer3, answer4]
        while !currentAnswers.isEmpty {
            questionButtons.forEach() { button in
                button?.setTitle(currentAnswers[0], for: .normal)
                currentAnswers.remove(at: 0)
            }
        }
        
        questionNumber.text = "Вопрос №\(questionCount + 1)"
        
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    
    /* ДОДЕЛАТЬ ПОСЛЕ ВСЕГО ОСТАЛЬНОГО
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
     */
    
    func checkAnswer(_ answer: String) -> Bool {
        if answer == chosenTheme.questionsAndAnswers[currentQuestion]?.first {
            return true
        }
        return false
    }
    
    func editQuestionProcessFunc() {
        if questionCount == questionsToComplete {
            chosenThemeQuestionsArray.remove(at: 0)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizResultID")
            self.present(vc, animated: true)
        } else {
            chosenThemeQuestionsArray.remove(at: 0)
            viewDidLoad()
            questionNumber.text = "Вопрос №\(questionCount+1)"
        }
    }
    
    
    @IBAction func answer1Chosen() {
        chosenAnswer = answer1.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
        questionCount += 1
        editQuestionProcessFunc()
    }
    
    @IBAction func answer2Chosen() {
        chosenAnswer = answer2.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
        questionCount += 1
        editQuestionProcessFunc()
    }
    
    @IBAction func answer3Chosen() {
        chosenAnswer = answer3.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
        questionCount += 1
        editQuestionProcessFunc()
    }
    
    @IBAction func answer4Chosen() {
        chosenAnswer = answer4.currentTitle!
        if checkAnswer(chosenAnswer) {
            question.textColor = UIColor.green
        } else { question.textColor = UIColor.red }
        questionCount += 1
        editQuestionProcessFunc()
    }
    
    
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
        questionCount = 0
    }
    
    
    
}

