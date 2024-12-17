//
//  ThirdViewController.swift
//  My First App
//
//  Created by Артем Табенский on 08.03.2024.
//

import UIKit

class SoundSettingsViewController: UIViewController {
    
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var hapticSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var notificationsSymbol: UIImageView!
    @IBOutlet weak var hapticSymbol: UIImageView!
    @IBOutlet weak var speakerSymbol: UIImageView!
    
    @IBOutlet weak var notificationsView: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var hapticView: UIView!
    
    @IBOutlet weak var haptic1: UIButton!
    @IBOutlet weak var haptic2: UIButton!
    @IBOutlet weak var haptic3: UIButton!
    @IBOutlet weak var hapticSelection: UIButton!
    @IBOutlet weak var hapticSuccess: UIButton!
    @IBOutlet weak var hapticError: UIButton!
    @IBOutlet weak var hapticWarning: UIButton!
    
    var hapticButtons: Array<UIButton>?
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    let selectionFeedback = UISelectionFeedbackGenerator()
    
    let animationsEngine = Animations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hapticButtons = [haptic1, haptic2, haptic3, hapticSelection, hapticSuccess, hapticError, hapticWarning]
        
        let viewsArray = [notificationsView, soundView, hapticView]
        viewsArray.forEach { elem in
            elem?.layer.masksToBounds = true
            elem?.traitOverrides.userInterfaceLevel = .elevated // переопределение приоритетных цветов (iOS 17+)
        }
    }
    
    
    private func disableElements() {
        let arrayToDisable = [hapticSwitch, soundSwitch, volumeSlider]
        arrayToDisable.forEach() { elem in
            elem?.isEnabled = false
        }
    }
    
    private func disableHapticButtons() {
        hapticButtons?.forEach() { button in
            UIView.animate(withDuration: 0.5) {
                button.isEnabled = false
            }
        }
    }
    
    private func disableSymbol(_ symbol: UIImageView) {
        let symbolName: String

        switch symbol {
        case notificationsSymbol:
            symbolName = "bell.slash"
        case hapticSymbol:
            symbolName = "iphone.slash"
        case speakerSymbol:
            symbolName = "speaker.slash"
        default:
            return
        }

        symbol.setSymbolImage(UIImage(systemName: symbolName)!, contentTransition: .replace)
        symbol.tintColor = UIColor.systemGray
        symbol.removeAllSymbolEffects()
    }
    
    private func resizeView(viewToResize: UIView, duration: Double, newHeight: CGFloat) {
        // Находим существующий констрейнт высоты
        guard let heightConstraint = viewToResize.constraints.first(where: { $0.firstAttribute == .height }) else {
            print("Height constraint not found")
            return
        }

        // Анимируем изменение высоты
        UIView.animate(withDuration: duration) {
            heightConstraint.constant = newHeight
            self.view.layoutIfNeeded() // Применяем изменения layout
        }
    }
    
    // MARK: - Notifications
    
    @IBAction private func notificationsSwitchEnabled(_ sender: UISwitch) {
        
        switch sender.isOn {
            
        case true:
            
            notificationsSymbol.setSymbolImage(UIImage(systemName: "bell")!, contentTransition: .replace)
            notificationsSymbol.tintColor = .primary
            
            hapticSwitch.isEnabled = true
            soundSwitch.isEnabled = true
            
        case false:
            
            [speakerSymbol, hapticSymbol, notificationsSymbol].forEach() { x in
                disableSymbol(x)
            }
            
            disableElements()
            
            soundSwitch.isOn = false
            resizeView(viewToResize: soundView, duration: 1, newHeight: 60)
            volumeSlider.value = 0
            volumeLabel.text = "0"
            
            hapticSwitch.isOn = false
            disableHapticButtons()
            resizeView(viewToResize: hapticView, duration: 1, newHeight: 60)
            
        }
    }
    
    // MARK: - Sounds
    
    @IBAction private func soundSwitchEnabled(_ sender: UISwitch) {
        
        switch sender.isOn {
            
        case true:
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker")!, contentTransition: .replace)
            speakerSymbol.tintColor = .primary
            
            volumeSlider.isEnabled = true
            
            resizeView(viewToResize: soundView, duration: 1, newHeight: 150)
            
        case false:
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker.slash")!, contentTransition: .replace)
            speakerSymbol.tintColor = UIColor.systemGray
            
            volumeSlider.isEnabled = false
            volumeSlider.value = 0
            volumeLabel.text = "0"
            
            resizeView(viewToResize: soundView, duration: 1, newHeight: 60)
        }
    }
    
    @IBAction private func volumeSliderChanged(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value)) %"
    }
    
    private func animateSpeakerSymbol(symbolName: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.speakerSymbol.alpha = 0
        }) { _ in
            self.speakerSymbol.image = UIImage(systemName: symbolName)
            UIView.animate(withDuration: 0.2) {
                self.speakerSymbol.alpha = 1
            }
        }
    }
    
    @IBAction func volumeSliderTouchedUp(_ sender: UISlider) {
        
        let volume = sender.value
        if volume == 0 && speakerSymbol.image != UIImage(systemName: "speaker") {
            animateSpeakerSymbol(symbolName: "speaker")
        }
        if (1...33).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.1") {
            animateSpeakerSymbol(symbolName: "speaker.wave.1")
        }
        if (34...66).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.2") {
            animateSpeakerSymbol(symbolName: "speaker.wave.2")
        }
        if (67...100).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.3") {
            animateSpeakerSymbol(symbolName: "speaker.wave.3")
        }
    }
    
    // MARK: - Haptics
    
    @IBAction func hapticSwitchChanged() {
        if hapticSwitch.isOn == true {
            
            hapticSymbol.setSymbolImage(UIImage(systemName: "iphone.motion", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .primary))!, contentTransition: .replace)
            hapticSymbol.addSymbolEffect(.wiggle, options: .repeat(30))
            #warning("Зациклить анимацию")
            
            resizeView(viewToResize: hapticView, duration: 1, newHeight: 225)
            
            DispatchQueue.main.async {
                for (index, button) in self.hapticButtons!.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
                        UIView.animate(withDuration: 0.5) {
                            button.isEnabled = true
                        }
                    }
                }
            }
            
        } else {
            disableSymbol(hapticSymbol)
            
            resizeView(viewToResize: hapticView, duration: 1, newHeight: 60)
            
            disableHapticButtons()
        }
    }
    
    @IBAction func hapticButtonTouchedDown(_ sender: UIButton) {
        
        animationsEngine.animateDownFloat(sender)
        
        switch sender.tag {
        case 1:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case 2:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case 3:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case 4:
            hapticFeedback.notificationOccurred(.success)
        case 5:
            hapticFeedback.notificationOccurred(.error)
        case 6:
            hapticFeedback.notificationOccurred(.warning)
        case 7:
            selectionFeedback.selectionChanged()
        case 8:
            break
        default:
            break
        }
    }
    
    @IBAction func hapticButtonTouchedUp(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
}

// 271
