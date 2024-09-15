//
//  FifthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.03.2024.
//

import UIKit

class FifthViewController: UIViewController {

    
    @IBOutlet weak var cookieButtonImage: UIButton!
    @IBOutlet weak var cookiesIncrementLabel: UILabel!
    @IBOutlet weak var totalCookies: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var fabricBuyLabel: UILabel!
    @IBOutlet weak var fabricBuyButton: UIButton!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    var numCookies = 0
    var incrementCookies = 1
    var fabricPrice = 1000
    var resultCookies1 = "no cookies"
    var name1 = "no name"
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func cookieButtonTouchDown() {
        generator.impactOccurred()
        
        cookieButtonImage.isHidden = true
        numCookies += incrementCookies
        totalCookies.text = "\(numCookies)"
        if numCookies >= fabricPrice {
            fabricBuyButton.isEnabled = true
        } else {
            fabricBuyButton.isEnabled = false
        }
    }
    
    @IBAction func cookieButtonTouchUpInside() {
        cookieButtonImage.isHidden = false
    }
    
    @IBAction func cookieButtonTouchUpOutside() {
        cookieButtonImage.isHidden = false
    }
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        incrementCookies = Int(stepper.value)
        cookiesIncrementLabel.text = "кол-во печенья в секунду: \(incrementCookies)"
    }
    
    @IBAction func fabricBought() {
        numCookies -= fabricPrice
        totalCookies.text = "\(numCookies)"
        activityindicator.startAnimating()
        fabricBuyLabel.text = "Везём фабрику с алиэкспресса..."
        fabricBuyButton.isEnabled = false
        fabricPrice *= 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.activityindicator.stopAnimating()
            self.fabricBuyLabel.text = "Фабрика куплена! Цена следующей - \(self.fabricPrice)"
            self.incrementCookies += 1000
            self.stepper.value += 1000
            self.cookiesIncrementLabel.text = "кол-во печенья в секунду: \(self.incrementCookies)"
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Уходите?", message: "Вы действительно хотите покинуть эту прекрасную мини-игру?", preferredStyle: .alert)
        alertController.addTextField() { textField in
            textField.placeholder = "Введите свой ник"
        }
        let action = UIAlertAction(title: "Да", style: .destructive) { _ in
            guard let name = alertController.textFields?.first?.text else { return }
            let resultCookies = "\(self.numCookies)"
            self.name1 = name
            self.resultCookies1 = resultCookies
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc6 = storyboard.instantiateViewController(withIdentifier: "six") as! SixthViewController
            vc6.name = self.name1 // переносим значения на следующий VC
            vc6.cookies = self.resultCookies1
            self.navigationController?.pushViewController(vc6, animated: true) // переход с использованием первого Navigation Controller
        }

        alertController.addAction(action)
        let action2 = UIAlertAction(title: "Нет", style: .cancel)
        alertController.addAction(action2)
        
        present(alertController, animated: true)
    }
}
