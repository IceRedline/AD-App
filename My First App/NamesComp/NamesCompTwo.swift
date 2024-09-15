//
//  ResultViewController.swift
//  NamesComp
//
//  Created by Артем Табенский on 05.03.2024.
//

import UIKit

class NamesCompTwo: UIViewController {
    
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var namesResult: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var firstName: String!
    var secondName: String!
    
    private var resultValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultValue = findResult()
        
        namesLabel.text = "\(firstName ?? "") and \(secondName ?? "")"
        namesResult.text = resultValue.formatted(.percent)
        
        progressView.progress = Float(resultValue) / 100
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4) // делаем progressbar толще
    }
    
    private func findValue(for name: String) -> Int {
        var count = 0
        
        for character in name.lowercased () {
            switch character {
            case "a", "i", "j", "q", "y":
                count += 1
            case "b", "k", "r":
                count += 2
            case "c", "g", "l", "s":
                count += 3
            case "d", "m", "t":
                count += 4
            case "e", "h", "n", "x":
                count += 5
            case "u", "v", "w":
                count += 6
            case "o", "z" :
                count += 7
            case "f", "p":
                count += 8
            default :
                count += 0
            }
        }
        if (firstName == "Artyom" && secondName == "Ann") || (firstName == "Ann" && secondName == "Artyom") {
            count = 7
        }
        return count
    }
    
    private func findResult () -> Int {
        var result = 0
        let firstValue = findValue(for: firstName)
        let
        secondValue = findValue (for: secondName)
        let absDifference = abs (firstValue - secondValue)
        switch absDifference {
        case
            0, 1, 2:
            result = 100
        case
            3, 4:
            result = 65
        case
            5:
            result = 50
        case
            6:
            result = 40
        case
            7:
            result = 99
        default:
            result = 30
        }
        return result
    }
    
}
