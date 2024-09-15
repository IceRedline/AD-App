//
//  RemindersTextPicker.swift
//  My First App
//
//  Created by Артем Табенский on 01.06.2024.
//

import UIKit

class TextPicker {
    
    func showTextPicker(in viewcontroller: UIViewController, completion: @escaping ((String) -> Void)) {
        let alertController = UIAlertController(title: "Reminders", message: "Введите значение", preferredStyle: .alert)
        alertController.addTextField() { textField in
            textField.placeholder = "Введите значение"
        }
        let actionOK = UIAlertAction(title: "Готово", style: .default) { _ in
            if let text = alertController.textFields?[0].text, text != "" { // обращаемся к 0-му элементу массива текстовых полей, проверяем на nil и на пустую строку
                completion(text)
            }
        }
        let actionCancel = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            
        }
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        viewcontroller.present(alertController, animated: true)
    }
}
