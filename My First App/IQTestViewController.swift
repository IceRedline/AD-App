//
//  SecondViewController.swift
//  My First App
//
//  Created by Артем Табенский on 07.03.2024.
//

import UIKit
import SwiftUI

class IQTestViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - @IBOutlet properties
    
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var dateButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    @IBOutlet private weak var hintDate1: UILabel!
    @IBOutlet private weak var hintDate2: UILabel!
    @IBOutlet private weak var hintDate3: UILabel!
    @IBOutlet private weak var hintDate4: UILabel!
    @IBOutlet private weak var hintsStack: UIStackView!
    
    // MARK: - Properties
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    var formattedDate = ""
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        formattedDate = dateFormatter.string(from: Date.now)
        
        dateTextField.delegate = self
        nameTextField.autocapitalizationType = .none
        
        hintDate1.text = Date().formatted(date: .numeric, time: .standard)
        hintDate2.text = Date().formatted(date: .abbreviated, time: .shortened)
        hintDate3.text = Date().formatted(date: .complete, time: .complete)
        hintDate4.text = Date().formatted(date: .long, time: .omitted)
        
        updateMenu(showDatesEnabled: true)
        dateButton.showsMenuAsPrimaryAction = false
    }
    
    // MARK: - Methods
    
    private func returnTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.firstLabel.text = "Введите текущую дату:"
        }
    }
    
    private func updateMenu(showDatesEnabled: Bool) {
        let showAction = UIAction(title: "Показать даты", attributes: showDatesEnabled ? [] : .disabled) { _ in
            self.hintsStack.isHidden = false
            self.updateMenu(showDatesEnabled: false)
        }
        
        let hideAction = UIAction(title: "Скрыть даты", attributes: showDatesEnabled ? .disabled : []) { _ in
            self.hintsStack.isHidden = true
            self.updateMenu(showDatesEnabled: true)
        }
        
        let menu = UIMenu(title: "Отображение дат", children: [showAction, hideAction])
        dateButton.menu = menu
    }
    
    
    
    @IBAction private func dateButtonTapped() {
        if dateTextField.text == formattedDate {
            hapticFeedback.notificationOccurred(.success)
            firstLabel.text = "Верно!"
            dateButton.isEnabled = false

            dateTextField.resignFirstResponder()
            dateTextField.isEnabled = false
            secondLabel.isEnabled = true
            nameTextField.isEnabled = true
        }
        else {
            if dateTextField.text == "" {
                hapticFeedback.notificationOccurred(.error)
                firstLabel.text = "Где?"
                returnTitle()
            } else {
                hapticFeedback.notificationOccurred(.error)
                firstLabel.text = "Неверно"
                returnTitle()
            }
        }
    }
    
    @IBAction private func nameFieldChanged(_ sender: Any) {
        if nameTextField.text?.count == 1 && (nameTextField.text![nameTextField.text!.startIndex] == "А" || nameTextField.text![nameTextField.text!.startIndex] == "а")
        {
            secondLabel.text = "Начало хорошее"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3 ) {
                self.secondLabel.text = "Введите лучшее имя:"
            }
        } else if nameTextField.text?.count == 1 {
            secondLabel.text = "Не ну это не туда"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3 ) {
                self.secondLabel.text = "Введите лучшее имя:"
            }
        } else {
            secondLabel.text = "Введите лучшее имя:"
        }
        
        if nameTextField.text == "Артем" || nameTextField.text == "Артём" {
            hapticFeedback.notificationOccurred(.success)
            secondLabel.text = "Абсолютно точно!"
            nameTextField.resignFirstResponder()
        } else if nameTextField.text == "артем" || nameTextField.text == "артём" {
            hapticFeedback.notificationOccurred(.error)
            secondLabel.text = "С большой буквы ало"
        }
        if firstLabel.text == "Верно!" && secondLabel.text == "Абсолютно точно!" {
            nextButton.isEnabled = true
        }
    }
}
