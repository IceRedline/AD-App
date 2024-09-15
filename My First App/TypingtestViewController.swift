//
//  TestViewController.swift
//  My First App
//
//  Created by Артем Табенский on 26.06.2024.
//

import UIKit

var text = ""
var textArray = [String]()

class TestViewController: UIViewController {
    
    var timer = Timer()
    var startTime = Date()
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fileURL = Bundle.main.url(forResource: "testtext", withExtension: "rtf") {
            do {
                let attributedString = try NSAttributedString(url: fileURL, options: [.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                text = attributedString.string
                textArray = text.components(separatedBy: "\n")
                print(textArray[0])
            } catch {
                print("Error reading RTF file: \(error.localizedDescription)")
            }
        } else {
            print("File not found.")
        }
        
    }
    
    @IBAction func textGeneratorTapped() {
        textField.isEnabled = true
        generateButton.setTitle("Другой текст", for: .normal)
        textLabel.text = textArray[Int.random(in: 0...8)]
    }
    
    @IBAction func editingBegan() {
        startTime = Date()
    }
    
    @IBAction func textFieldChanged() {
        if textLabel.text!.contains(textField.text!) {
            errorLabel.text = "Typing test"
            textLabel.textColor = UIColor.label
        } else {
            errorLabel.text = "Ошибка!"
            textLabel.textColor = .red
        }
        
        if textLabel.text! == textField.text! {
            textField.resignFirstResponder()
            let seconds = Date().timeIntervalSince(startTime)
            let minutes = seconds / 60
            let charactersPerMinute = Double(textField.text!.count) / minutes
            resultLabel.text = String(format: "Твой результат: %.2f зн/мин.", charactersPerMinute)
        }
    }
}


    

