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
public var correctAnswers = 0

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
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        let questionButtons = [answer1, answer2, answer3, answer4]
        questionButtons.forEach() { button in button!.isEnabled = true }
        
        super.viewDidLoad()
        themeName.text = chosenTheme.name
        question.textColor = .white
        currentQuestion = chosenThemeQuestionsArray[0]
        question.text = currentQuestion
        var currentAnswers = chosenTheme.questionsAndAnswers[currentQuestion]!.shuffled()

        
        while !currentAnswers.isEmpty {
            questionButtons.forEach() { button in
                button?.setTitle(currentAnswers[0], for: .normal)
                currentAnswers.remove(at: 0)
            }
        }
        
        questionNumber.text = "Вопрос №\(questionCount + 1)"
        nextButton.isEnabled = false
        
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
    
    func checkAnswer(_ answer: UIButton) {
        let questionButtons = [answer1, answer2, answer3, answer4]
        questionButtons.forEach() { button in button!.isEnabled = false }
        nextButton.isEnabled = true
        questionCount += 1
        if answer.currentTitle! == chosenTheme.questionsAndAnswers[currentQuestion]?.first {
            question.textColor = UIColor.green
            correctAnswers += 1
        } else {
            question.textColor = UIColor.red
        }
        //goLastOrGoNext()
    }
    
    @IBAction func answer1Chosen() {
        checkAnswer(answer1)
    }
    
    @IBAction func answer2Chosen() {
        checkAnswer(answer2)
    }
    
    @IBAction func answer3Chosen() {
        checkAnswer(answer3)
    }
    
    @IBAction func answer4Chosen() {
        checkAnswer(answer4)
    }
    
    @IBAction func nextButtonTapped() {
        if questionCount == questionsToComplete {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizResultID")
            self.present(vc, animated: true)
            chosenThemeQuestionsArray.remove(at: 0)
        } else {
            chosenThemeQuestionsArray.remove(at: 0)
            viewDidLoad()
        }
        
    }
    
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
        questionCount = 0
    }
    
    
    
}

