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
var currentProgress = 0.2

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
    
    let notificationFeedback = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let questionButtons = [answer1, answer2, answer3, answer4]
        questionButtons.forEach() { button in
            button?.backgroundColor = UIColor(red: 31/255.0, green: 40/255.0, blue: 59/255.0, alpha: 1.0)
            button!.setTitleColor(.gray, for: .disabled)
            button!.isEnabled = true
        }
        timerBar.tintColor = .systemBlue
        timerBar.progress = Float(currentProgress)
        
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
        questionButtons.forEach() { button in
            button!.setTitleColor(.gray, for: .disabled)
            button!.isEnabled = false
            if button?.currentTitle == chosenTheme.questionsAndAnswers[currentQuestion]?.first {
                button!.setTitleColor(.white, for: .disabled)
                button?.backgroundColor = UIColor(red: 36/255.0, green: 50/255.0, blue: 59/255.0, alpha: 1.0)
            } else {
                button?.backgroundColor = UIColor(red: 40/255.0, green: 32/255.0, blue: 58/255.0, alpha: 1.0)
            }
        }
        nextButton.isEnabled = true
        questionCount += 1
        currentProgress += 0.2
        if answer.currentTitle! == chosenTheme.questionsAndAnswers[currentQuestion]?.first {
            notificationFeedback.notificationOccurred(.success)
            timerBar.tintColor = UIColor(red: 90/255.0, green: 137/255.0, blue: 87/255.0, alpha: 1.0)
            correctAnswers += 1
        } else {
            notificationFeedback.notificationOccurred(.error)
            timerBar.tintColor = UIColor(red: 78/255.0, green: 58/255.0, blue: 115/255.0, alpha: 1.0)
        }
    }
    
    @IBAction func answerChosen(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            checkAnswer(answer1)
        case 2:
            checkAnswer(answer2)
        case 3:
            checkAnswer(answer3)
        case 4:
            checkAnswer(answer4)
        default:
            break
        }
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
