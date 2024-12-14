//
//  CalculatorViewController.swift
//  My First App
//
//  Created by Артем Табенский on 14.11.2024.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet private weak var numberLabel: UILabel!
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
    
    let animationsEngine = Animations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func calculate() {
        
        switch currentAction {
        case "%":
            currentNumber /= 100
            break
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
        /*
        if currentSender != nil {
            changeNumberFlag(currentSender!)
        }
         */
        currentAction = nil
    }
    
    private func changeNumberFlag(_ sender: UIButton) {
        numberSwitched = true
        currentSender = sender
    }
    
    @IBAction func numberButtonTouchedDown(_ sender: UIButton) {
        animationsEngine.animateDownFloat(sender)
    }
    
    @IBAction func numberButtonTouchedUp(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
        if currentNumber == 0 || numberSwitched {
            currentNumber = sender.tag
        } else {
            currentNumber = Int(String(currentNumber) + String(sender.tag)) ?? 404
        }
        numberSwitched = false
    }
    
    @IBAction func actionButtonTouchedUp(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            currentNumber = 0
            currentAction = nil
        case 11:
            currentAction = "%"
            firstNumber = currentNumber
        case 12:
            calculate()
            changeNumberFlag(sender)
            animationsEngine.animateUpBackgroundColor(sender)
            currentAction = "/"
            firstNumber = currentNumber
        case 13:
            calculate()
            changeNumberFlag(sender)
            animationsEngine.animateUpBackgroundColor(sender)
            currentAction = "*"
            firstNumber = currentNumber
        case 14:
            calculate()
            changeNumberFlag(sender)
            animationsEngine.animateUpBackgroundColor(sender)
            currentAction = "-"
            firstNumber = currentNumber
        case 15:
            calculate()
            changeNumberFlag(sender)
            animationsEngine.animateUpBackgroundColor(sender)
            currentAction = "+"
            firstNumber = currentNumber
        case 16:
            if currentSender != nil {
                animationsEngine.animateUpBackgroundColor(currentSender!)
            }
            currentSender = nil
            calculate()
        default:
            break
        }
    }
}
