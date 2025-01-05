//
//  FifthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.03.2024.
//

import UIKit

import UIKit

class CookieClickerViewController: UIViewController {

    // MARK: - @IBOutlet properties
    
    @IBOutlet private weak var cookieButtonImage: UIButton!
    @IBOutlet private weak var cookiesIncrementLabel: UILabel!
    @IBOutlet private weak var totalCookies: UILabel!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var fabricBuyLabel: UILabel!
    @IBOutlet private weak var fabricBuyButton: UIButton!
    @IBOutlet private weak var activityindicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var cookiesCount = 0
    private var incrementCookies = 1
    private var fabricPrice = 1000
    
    private let storage = UserDefaults.standard
    private var result: GameResult?
    private var results: Array<GameResult>?
    private var startTime: Date?
    
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let factoryHapticFeedback = UINotificationFeedbackGenerator()
    private let animationsEngine = Animations()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedData = UserDefaults.standard.data(forKey: "cookieClickerResults"),
           let decodedResults = try? JSONDecoder().decode([GameResult].self, from: savedData) {
            results = decodedResults
            print("Результаты загружены: \(decodedResults)")
        } else {
            
            print("Не удалось загрузить результаты")
        }
        
        startTime = Date()
    }

    // MARK: - Methods
    
    @IBAction private func cookieButtonTouchDown() {
        hapticFeedback.impactOccurred()
        
        animationsEngine.animateDownFloat(cookieButtonImage, duration: 0.2)
        
        cookiesCount += incrementCookies
        totalCookies.text = "\(cookiesCount)"
        if cookiesCount >= fabricPrice {
            fabricBuyButton.isEnabled = true
        } else {
            fabricBuyButton.isEnabled = false
        }
    }
    
    @IBAction private func cookieButtonTouchUpInside() {
        animationsEngine.animateUpFloat(cookieButtonImage, duration: 0.2)
    }
    
    @IBAction private func cookieButtonTouchUpOutside() {
        animationsEngine.animateUpFloat(cookieButtonImage, duration: 0.2)
    }
    
    
    @IBAction private func stepperChanged(_ sender: UIStepper) {
        incrementCookies = Int(stepper.value)
        cookiesIncrementLabel.text = "кол-во печенья в секунду: \(incrementCookies)"
    }
    
    @IBAction private func fabricBought() {
        cookiesCount -= fabricPrice
        totalCookies.text = "\(cookiesCount)"
        fabricBuyButton.showsActivityIndicator = true
        fabricBuyLabel.text = "Везём фабрику с алиэкспресса..."
        fabricBuyButton.isEnabled = false
        fabricPrice *= 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.factoryHapticFeedback.notificationOccurred(.success)
            self.fabricBuyButton.setTitle("Купить", for: .normal)
            self.fabricBuyButton.showsActivityIndicator = false
            self.fabricBuyLabel.text = "Фабрика куплена! Цена следующей - \(self.fabricPrice)"
            self.incrementCookies += 1000
            self.stepper.value += 1000
            self.cookiesIncrementLabel.text = "кол-во печенья в секунду: \(self.incrementCookies)"
        }
    }
    
    @IBAction private func nextButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: "Уходите?",
            message: "Вы действительно хотите покинуть эту прекрасную мини-игру?",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "Введите свой ник"
        }
        let action = UIAlertAction(title: "Да", style: .destructive) { [self] _ in
            guard let name = alertController.textFields?.first?.text else { return }
            
            let playTime = Date().timeIntervalSince(startTime ?? Date())

            let seconds = String(format: "%.1f сек.", playTime)
            
            result = GameResult(
                name: name,
                score: cookiesCount,
                date: Date(),
                time: seconds
            )
            storage.set("\(name): \(cookiesCount)", forKey: "cookieClickerLastResult")
            results?.append(self.result!)
            
            if let encoded = try? JSONEncoder().encode(results) {
                UserDefaults.standard.set(encoded, forKey: "cookieClickerResults")
                print("Результаты сохранены: \(encoded)") 
            }
    
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc6 = storyboard.instantiateViewController(withIdentifier: "six") as! CookieResultsViewController
            self.navigationController?.pushViewController(vc6, animated: true)
        }

        alertController.addAction(action)
        let action2 = UIAlertAction(title: "Нет", style: .cancel)
        alertController.addAction(action2)
        
        present(alertController, animated: true)
    }
}


// MARK: - Extensions

extension UIButton {
    private struct AssociatedKeys {
        static var activityIndicator = "activityIndicator"
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var showsActivityIndicator: Bool {
        get {
            return activityIndicator != nil
        }
        set {
            if newValue {
                let indicator = UIActivityIndicatorView(style: .medium)
                indicator.translatesAutoresizingMaskIntoConstraints = false
                addSubview(indicator)
                
                NSLayoutConstraint.activate([
                    indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                    indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
                
                indicator.startAnimating()
                activityIndicator = indicator
                self.setTitle("", for: .normal) // Скрываем текст кнопки
            } else {
                activityIndicator?.stopAnimating()
                activityIndicator?.removeFromSuperview()
                activityIndicator = nil
            }
        }
    }
}
