//
//  ViewController.swift
//  NamesComp
//
//  Created by Артем Табенский on 05.03.2024.
//

import UIKit

class NamesCompOne: UIViewController {

    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnerNameTF: UITextField!
    
    @IBOutlet weak var someLabel: UILabel!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? NamesCompTwo else { return }
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else { return }
        if firstName.isEmpty || secondName.isEmpty{
            showAlert(title: "Names are missing",
                      message: "Please enter both names"
            )
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        yourNameTF.text = ""
        partnerNameTF.text = ""
        
        guard let sourceVC = segue.source as? NamesCompTwo else { return }
        someLabel.text = "Previously compared: \(sourceVC.namesLabel.text ?? "")"
    }
}

extension NamesCompOne {
    private func showAlert(title: String, message: String){ // всплывающее окно
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // предупреждение
        let okAction = UIAlertAction(title: "OK", style: .default) // кнопка ok
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension NamesCompOne: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnerNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
}
