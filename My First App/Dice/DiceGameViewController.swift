//
//  DiceGameViewController.swift
//  My First App
//
//  Created by Артем Табенский on 12.06.2024.
//

import UIKit

class DiceGameViewController: UIViewController {

    @IBOutlet private weak var diceOneImage: UIImageView!
    @IBOutlet private weak var diceTwoImage: UIImageView!
    @IBOutlet private weak var resultOneLabel: UILabel!
    @IBOutlet private weak var resultTwoLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var winLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    private var dice: [Dice] = [Dice(number: "1", image: UIImage(named: "dice1.png")),
                        Dice(number: "2", image: UIImage(named: "dice2.png")),
                        Dice(number: "3", image: UIImage(named: "dice3.png")),
                        Dice(number: "4", image: UIImage(named: "dice4.png")),
                        Dice(number: "5", image: UIImage(named: "dice5.png")),
                        Dice(number: "6", image: UIImage(named: "dice6.png"))]
    
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .light)
    private let resultHapticFeedback = UINotificationFeedbackGenerator()
    
    private var timer1: Timer?
    private var timer2: Timer?
    private var wins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        
        playButton.isEnabled = false
        textLabel.text = "Испытай свою удачу, бросив кубик против Айса!"
        resultOneLabel.text = "-"
        resultTwoLabel.text = "-"
        var dice1 = dice[0]
        var dice2 = dice[0]
        
        timer1 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.hapticFeedback.impactOccurred()
            let dice01 = self.dice[Int.random(in: 0...5)]
            self.diceOneImage.image = dice01.image
            dice1 = dice01
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timer1?.invalidate() // Остановка первой анимации
            self.resultOneLabel.text = dice1.number
            self.timer2 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.hapticFeedback.impactOccurred()
                let dice02 = self.dice[Int.random(in: 0...5)]
                self.diceTwoImage.image = dice02.image
                dice2 = dice02
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.timer2?.invalidate() // Остановка второй анимации
            self.resultTwoLabel.text = dice2.number
            self.playButton.isEnabled = true
            if Int(dice1.number)! < Int(dice2.number)! {
                self.resultHapticFeedback.notificationOccurred(.success)
                self.textLabel.text = "Отлично, ты выиграл! Попробуешь ещё раз?"
                self.wins += 1
                self.winLabel.text = "Количество побед подряд: \(self.wins)"
            } else if Int(dice1.number)! == Int(dice2.number)! {
                self.resultHapticFeedback.notificationOccurred(.error)
                self.textLabel.text = "Ничья, значит Айс победил, так как он создатель всего этого беспредела :D"
                self.wins = 0
                self.winLabel.text = "Количество побед подряд: \(self.wins)"
            } else {
                self.resultHapticFeedback.notificationOccurred(.error)
                self.textLabel.text = "Ты проиграл! Неудивительно)"
                self.wins = 0
                self.winLabel.text = "Количество побед подряд: \(self.wins)"
            }
        }
        
    }
    
}
