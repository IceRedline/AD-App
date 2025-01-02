//
//  QuizQuestionViewController.swift
//  My First App
//
//  Created by Артем Табенский on 02.10.2024.
//

import UIKit

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
    
    var questionButtons: Array<UIButton>?
    let notificationFeedback = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionButtons = [answer1, answer2, answer3, answer4]
        questionButtons?.forEach() { button in
            button.backgroundColor = UIColor(red: 31/255.0, green: 40/255.0, blue: 59/255.0, alpha: 1.0)
            button.setTitleColor(.gray, for: .disabled)
            button.isEnabled = true
        }
        timerBar.tintColor = .systemBlue
        timerBar.progress = Float(QuizFactory.shared.currentProgress)
        
        themeName.text = QuizFactory.shared.chosenTheme.name
        question.textColor = .white
        QuizFactory.shared.currentQuestion = QuizFactory.shared.chosenThemeQuestionsArray[0]
        question.text = QuizFactory.shared.currentQuestion
        var currentAnswers = QuizFactory.shared.chosenTheme.questionsAndAnswers[QuizFactory.shared.currentQuestion]!.shuffled()
        
        
        while !currentAnswers.isEmpty {
            questionButtons?.forEach() { button in
                button.setTitle(currentAnswers[0], for: .normal)
                currentAnswers.remove(at: 0)
            }
        }
        
        questionNumber.text = "Вопрос №\(QuizFactory.shared.questionCount + 1)"
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
    
    @IBAction func answerChosen(_ sender: UIButton) {
            
            let isCorrect = QuizFactory.shared.checkAnswer(selectedAnswer: sender)
            
            questionButtons?.forEach() { button in
                button.isEnabled = false
                if QuizFactory.shared.checkAnswer(selectedAnswer: button) {
                    button.setTitleColor(.white, for: .disabled)
                    button.backgroundColor = .correctAnswerButton
                } else {
                    button.backgroundColor = .wrongAnswerButton
                }
            }
            
            if isCorrect {
                notificationFeedback.notificationOccurred(.success)
                timerBar.tintColor = .correctAnswerBar
            } else {
                notificationFeedback.notificationOccurred(.error)
                timerBar.tintColor = .wrongAnswerBar
            }
            
            QuizFactory.shared.updateQuizState(isCorrect: isCorrect)
            nextButton.isEnabled = true
        }
    
    @IBAction func nextButtonTapped() {
        if QuizFactory.shared.questionCount == QuizFactory.shared.questionsToComplete {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizResultID")
            self.present(vc, animated: true)
            QuizFactory.shared.chosenThemeQuestionsArray.remove(at: 0)
        } else {
            QuizFactory.shared.chosenThemeQuestionsArray.remove(at: 0)
            viewDidLoad()
        }
        
    }
    
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
        QuizFactory.shared.resetProgress()
    }
    
}
