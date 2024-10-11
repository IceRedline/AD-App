//
//  ThirdViewController.swift
//  My First App
//
//  Created by Артем Табенский on 08.03.2024.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var hapticSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var notificationsSymbol: UIImageView!
    @IBOutlet weak var hapticSymbol: UIImageView!
    @IBOutlet weak var soundSymbol: UIImageView!
    
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var hapticLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
    @IBOutlet weak var haptic1: UIButton!
    @IBOutlet weak var haptic2: UIButton!
    @IBOutlet weak var haptic3: UIButton!
    @IBOutlet weak var hapticSuccess: UIButton!
    @IBOutlet weak var hapticError: UIButton!
    @IBOutlet weak var hapticWarning: UIButton!
    @IBOutlet weak var hapticSelection: UIButton!
    @IBOutlet weak var haptic8: UIButton!
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    let selectionFeedback = UISelectionFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationsLabel.layer.masksToBounds = true
        hapticLabel.layer.masksToBounds = true
        soundLabel.layer.masksToBounds = true
        notificationsLabel.layer.cornerRadius = 15
        hapticLabel.layer.cornerRadius = 15
        soundLabel.layer.cornerRadius = 15
        
        notificationsLabel.traitOverrides.userInterfaceLevel = .elevated // переопределение приоритетных цветов (iOS 17+)
        hapticLabel.traitOverrides.userInterfaceLevel = .elevated
        soundLabel.traitOverrides.userInterfaceLevel = .elevated
    }
    
    
    @IBAction func notificationsSwitchEnabled(_ sender: UISwitch) {
        notificationsSymbol.image = UIImage(systemName: "bell")
        notificationsSymbol.tintColor = UIColor.systemBlue
        let alertController = UIAlertController(title: "Уведомления", message: "Уведомления включены!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(action)
        if notificationsSwitch.isOn == true {
            present(alertController, animated: true)
        }
        
        if notificationsSwitch.isOn == false {
            notificationsSymbol.image = UIImage(systemName: "bell.slash")
            notificationsSymbol.tintColor = UIColor.systemGray
            hapticSwitch.isOn = false
            soundSwitch.isOn = false
            hapticSwitch.isEnabled = false
            soundSwitch.isEnabled = false
            volumeSlider.isEnabled = false
            volumeSlider.value = 0
            volumeLabel.text = "0"
            nextButton.tintColor = .gray
            nextButton.isEnabled = false
        } else {
            hapticSwitch.isEnabled = true
            soundSwitch.isEnabled = true
        }
    }
    
    @IBAction func soundSwitchEnabled(_ sender: UISwitch) {
        if soundSwitch.isOn == true {
            soundSymbol.image = UIImage(systemName: "speaker")
            soundSymbol.tintColor = UIColor.systemBlue
            volumeSlider.isEnabled = true
        } else {
            soundSymbol.image = UIImage(systemName: "speaker.slash")
            soundSymbol.tintColor = UIColor.systemGray
            volumeSlider.isEnabled = false
            volumeSlider.value = 0
            volumeLabel.text = "0"
            nextButton.tintColor = .gray
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value)) %"
        
        if volumeSlider.value == 0 {
            soundSymbol.image = UIImage(systemName: "speaker")
        }
        if volumeSlider.value > 0 && volumeSlider.value <= 33 {
            soundSymbol.image = UIImage(systemName: "speaker.wave.1")
        }
        if volumeSlider.value > 33 && volumeSlider.value <= 66 {
            soundSymbol.image = UIImage(systemName: "speaker.wave.2")
        }
        if volumeSlider.value > 66{
            soundSymbol.image = UIImage(systemName: "speaker.wave.3")
        }
        
        if volumeSlider.value == 100 {
            nextButton.tintColor = UIColor.systemBlue
            nextButton.isEnabled = true
        } else {
            nextButton.tintColor = .gray
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func hapticSwitchChanged() {
        let hapticButtons = [haptic1, haptic2, haptic3, hapticSuccess, hapticError, hapticWarning, hapticSelection, haptic8]
        if hapticSwitch.isOn == true {
            hapticSymbol.image = UIImage(systemName: "iphone.radiowaves.left.and.right")
            hapticSymbol.tintColor = UIColor.systemBlue
            hapticButtons.forEach() { button in
                button?.isEnabled = true
            }
        } else {
            hapticSymbol.image = UIImage(systemName: "iphone.slash")
            hapticSymbol.tintColor = UIColor.systemGray
            hapticButtons.forEach() { button in
                button?.isEnabled = false
            }
        }
    }
    
    @IBAction func haptic1touched() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    @IBAction func haptic2touched() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    @IBAction func haptic3touched() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    @IBAction func hapticSuccessTouched() {
        hapticFeedback.notificationOccurred(.success)
    }
    @IBAction func hapticErrorTouched() {
        hapticFeedback.notificationOccurred(.error)
    }
    @IBAction func hapticWarningTouched() {
        hapticFeedback.notificationOccurred(.warning)
    }
    @IBAction func hapticSelectionTouched() {
        selectionFeedback.selectionChanged()
    }
    @IBAction func haptic8touched() {
        
    }
    
}
