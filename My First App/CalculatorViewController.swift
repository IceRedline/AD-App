//
//  CalculatorViewController.swift
//  My First App
//
//  Created by Артем Табенский on 14.11.2024.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var copiedLabel: UILabel!
    
    private var currentNumber: Int {
        get {
            return Int(numberLabel.text ?? "") ?? 0
        }
        set {
            numberLabel.text = String(newValue)
        }
    }
    private var firstNumber = 0
    private var currentAction: String?
    private var currentSender: UIButton?
    private var numberSwitched = false
    private var canStartAgain = true
    
    private let animationsEngine = Animations()
    private let startColor: CGColor = UIColor.calculatorGray.cgColor // CGColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
    private let endColor: CGColor = UIColor.calculatorGrayAccent.cgColor // CGColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        copiedLabel.layer.masksToBounds = true
    }
    
    private func calculate() {
        
        switch currentAction {
        case "/":
            currentNumber = firstNumber / currentNumber
            break
        case "*":
            currentNumber *= firstNumber
            break
        case "-":
            currentNumber = firstNumber - currentNumber
            break
        case "+":
            currentNumber += firstNumber
        default:
            break
        }
        firstNumber = 0
        currentAction = nil
    }
    
    @IBAction private func numberButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender, duration: 0.1)
    }
    
    @IBAction private func numberButtonTouchedUp(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender, duration: 0.1)
        if currentNumber == 0 || numberSwitched || canStartAgain {
            currentNumber = sender.tag
        } else {
            currentNumber = Int(String(currentNumber) + String(sender.tag)) ?? 404
        }
        canStartAgain = false
        numberSwitched = false
    }
    
    @IBAction private func actionButtonTouchedDown(_ sender: UIButton) {
        if ![10, 16].contains(sender.tag) {
            animationsEngine.animateBackgroundColor(sender, color: endColor)
        }
    }
    
    @IBAction private func actionButtonTouchedUp(_ sender: UIButton) {
        if ![10, 16].contains(sender.tag) {
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentSender = sender
        }
        
        if (currentSender != nil) || sender.tag == 11 {
            animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
        }
        
        
        switch sender.tag {
        case 10:
            if currentSender != nil {
                animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
            }
            currentNumber = 0
            currentAction = nil
        case 11:
            currentNumber /= 100
            canStartAgain = true
        case 12:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "/"
            firstNumber = currentNumber
        case 13:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "*"
            firstNumber = currentNumber
        case 14:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "-"
            firstNumber = currentNumber
        case 15:
            calculate()
            numberSwitched = true
            animationsEngine.animateBackgroundColor(sender, color: endColor)
            currentAction = "+"
            firstNumber = currentNumber
        case 16:
            if currentSender != nil {
                animationsEngine.animateBackgroundColor(currentSender!, color: startColor)
            }
            currentSender = nil
            calculate()
            canStartAgain = true
        default:
            break
        }
    }
    
    @IBAction private func copyButtonTapped() {
        UIPasteboard.general.string = numberLabel.text
        copiedLabel.fadeIn(0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.copiedLabel.fadeOut(0.3)
        }
    }
    
}
