//
//  FourthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 08.03.2024.
//

import UIKit

class PhotoEditorViewController: UIViewController {

    @IBOutlet private weak var alphaSlider: UISlider!
    @IBOutlet private weak var alphaLabel: UILabel!
    @IBOutlet private weak var blurSlider: UISlider!
    @IBOutlet private weak var blurLabel: UILabel!
    @IBOutlet private weak var cornerRadiusLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    
    
    let imagePicker = ImagePicker()
    var blurEffectView: UIVisualEffectView?
    var slidersArray: Array<UISlider>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slidersArray = [alphaSlider, blurSlider, cornerRadiusSlider]
    }
    
    
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        // Открываем UIImagePickerController с указанным источником
        imagePicker.showImagePicker(in: self, sourceType: sourceType) { image in
            self.slidersArray?.forEach({ elem in
                elem.isEnabled = true
            })
            self.buttonsStack.isHidden = true
            self.imageView.image = image
        }
    }
    
    @IBAction private func choosePictureButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            // Создаем UIAlertController
            let alertController = UIAlertController(title: "Выберите источник", message: nil, preferredStyle: .actionSheet)
            
            // Добавляем действие для открытия галереи
            let galleryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
                self.openImagePicker(sourceType: .photoLibrary)
            }
            alertController.addAction(galleryAction)
            
            // Добавляем действие для открытия камеры
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
                    self.openImagePicker(sourceType: .camera)
                }
                alertController.addAction(cameraAction)
            }
            
            // Добавляем действие для отмены
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            // Отображаем UIAlertController
            present(alertController, animated: true, completion: nil)
        case 2:
            buttonsStack.isHidden = true
            imageView.image = UIImage(named: "UIKit")
        default: return
        }
    }
    

    @IBAction private func alphaSliderChanged(_ sender: UISlider) {
        imageView.alpha = CGFloat(sender.value)
        alphaLabel.text = "\(round(sender.value * 10) / 10)"
    }
    
    
    @IBAction private func cornerRadiusSliderChanged(_ sender: UISlider) {
        imageView.layer.cornerRadius = CGFloat(sender.value * 40)
        cornerRadiusLabel.text = "\(Int(sender.value * 40))"
    }
    

    @IBAction private func blurSliderChanged(_ sender: UISlider) {
        blurLabel.text = "\(Int(sender.value * 10000) / 100)%"
        let blurValue = CGFloat(sender.value)
        
        // Если уже есть существующий blurEffectView, уберите его
        blurEffectView?.removeFromSuperview()
        
        // Создайте и добавьте новый blurEffectView с учетом текущего значения ползунка
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = imageView.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Примените размытие только если ползунок установлен на ненулевое значение
        if blurValue > 0 {
            blurEffectView?.alpha = blurValue // Контролируем степень размытия через альфу
            imageView.addSubview(blurEffectView!)
        }
    }
    

    @IBAction private func colorSegmentChanged(_ sender: UISegmentedControl) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // Сбрасывает на базовые настройки

        switch sender.selectedSegmentIndex {
        case 0:
            overrideUserInterfaceStyle = .unspecified
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
            appearance.backgroundColor = .systemBackground // Устанавливаем цвет фона
        case 1:
            overrideUserInterfaceStyle = .dark
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .systemGray6.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)) // Устанавливаем цвет фона
        case 2:
            overrideUserInterfaceStyle = .light
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = .systemGray6.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light)) // Устанавливаем цвет фона
        default:
            view.backgroundColor = UIColor.systemGray6
        }
        
        navigationController?.navigationBar.standardAppearance = appearance

        // Обновляем внешний вид
        navigationController?.navigationBar.setNeedsLayout()
    }
}
