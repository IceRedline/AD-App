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
        if currentSender != nil {
            changeColor(currentSender!)
        }
        currentAction = nil
    }
    
    private func changeColor(_ sender: UIButton) {
        numberSwitched = true
        #warning ("переместить numberSwitched в другой метод")
        
        if currentAction == nil {
            sender.backgroundColor = UIColor.systemGray6
        } else {
            sender.backgroundColor = UIColor.systemGray4
        }
        currentSender = sender
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if currentNumber == 0 || numberSwitched {
            currentNumber = sender.tag
        } else {
            currentNumber = Int(String(currentNumber) + String(sender.tag)) ?? 404
        }
        numberSwitched = false
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            currentNumber = 0
            currentAction = nil
        case 11:
            currentAction = "%"
            firstNumber = currentNumber
        case 12:
            calculate()
            changeColor(sender)
            currentAction = "/"
            firstNumber = currentNumber
        case 13:
            calculate()
            changeColor(sender)
            currentAction = "*"
            firstNumber = currentNumber
        case 14:
            calculate()
            changeColor(sender)
            currentAction = "-"
            firstNumber = currentNumber
        case 15:
            calculate()
            changeColor(sender)
            currentAction = "+"
            firstNumber = currentNumber
        case 16:
            if currentSender != nil  {
                changeColor(currentSender!)
            }
            currentSender = nil
            calculate()
        default:
            break
        }
    }
}
