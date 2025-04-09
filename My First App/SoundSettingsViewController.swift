//
//  ThirdViewController.swift
//  My First App
//
//  Created by Артем Табенский on 08.03.2024.
//

import UIKit

class SoundSettingsViewController: UIViewController {
    
    // MARK: - @IBOutlet properties
    
    @IBOutlet private weak var notificationsView: UIView!
    @IBOutlet private weak var soundView: UIView!
    @IBOutlet private weak var hapticView: UIView!
    
    @IBOutlet private weak var notificationsSwitch: UISwitch!
    @IBOutlet private weak var hapticSwitch: UISwitch!
    @IBOutlet private weak var soundSwitch: UISwitch!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var volumeSlider: UISlider!
    @IBOutlet private weak var notificationsSymbol: UIImageView!
    @IBOutlet private weak var hapticSymbol: UIImageView!
    @IBOutlet private weak var speakerSymbol: UIImageView!
    
    @IBOutlet private weak var hapticButton1: UIButton!
    @IBOutlet private weak var hapticButton2: UIButton!
    @IBOutlet private weak var hapticButton3: UIButton!
    @IBOutlet private weak var hapticSelectionButton: UIButton!
    @IBOutlet private weak var hapticSuccessButton: UIButton!
    @IBOutlet private weak var hapticErrorButton: UIButton!
    @IBOutlet private weak var hapticWarningButton: UIButton!
    
    // MARK: - Properties
    
    private var hapticButtons: Array<UIButton>?
    private let hapticFeedback = UINotificationFeedbackGenerator()
    private let selectionFeedback = UISelectionFeedbackGenerator()
    private let animationsEngine = Animations()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hapticButtons = [hapticButton1, hapticButton2, hapticButton3, hapticSelectionButton, hapticSuccessButton, hapticErrorButton, hapticWarningButton]
        
        let viewsArray = [notificationsView, soundView, hapticView]
        viewsArray.forEach {
            $0?.layer.masksToBounds = true
            $0?.traitOverrides.userInterfaceLevel = .elevated // переопределение приоритетных цветов (iOS 17+)
        }
    }
    
    // MARK: - Methods
    
    private func disableElements() {
        let arrayToDisable = [hapticSwitch, soundSwitch, volumeSlider]
        arrayToDisable.forEach() {
            $0?.isEnabled = false
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
    
    @IBAction private func notificationsSwitchToggled(_ sender: UISwitch) {
        
        switch sender.isOn {
            
        case true:
            
            notificationsSymbol.setSymbolImage(UIImage(systemName: "bell")!, contentTransition: .replace)
            notificationsSymbol.tintColor = .primary
            
            hapticSwitch.isEnabled = true
            soundSwitch.isEnabled = true
            
        case false:
            
            [speakerSymbol, hapticSymbol, notificationsSymbol].forEach() {
                disableSymbol($0)
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
    
    @IBAction private func soundSwitchToggled(_ sender: UISwitch) {
        
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
        
        let volume = sender.value
        if volume == 0 && speakerSymbol.image != UIImage(systemName: "speaker") {
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker")!, contentTransition: .replace)
        }
        if (1...33).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.1") {
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker.wave.1")!, contentTransition: .replace)
        }
        if (34...66).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.2") {
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker.wave.2")!, contentTransition: .replace)
        }
        if (67...100).contains(volume) && speakerSymbol.image != UIImage(systemName: "speaker.wave.3") {
            speakerSymbol.setSymbolImage(UIImage(systemName: "speaker.wave.3")!, contentTransition: .replace)
        }
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
    // MARK: - Haptics
    
    @IBAction private func hapticSwitchToggled() {
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
    
    @IBAction private func hapticButtonTouchedDown(_ sender: UIButton) {
        
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
    
    @IBAction private func hapticButtonTouchedUp(_ sender: UIButton) {
        animationsEngine.animateUpFloat(sender)
    }
    
}
