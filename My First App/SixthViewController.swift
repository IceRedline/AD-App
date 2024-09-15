//
//  SixthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.03.2024.
//

import UIKit

class SixthViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var name: String = "" 
    var cookies: String = ""
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var EasterEggLabel: UILabel!
    @IBOutlet weak var easterEggImage: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    let imagePicker = ImagePicker()
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    override func viewDidLoad() {
        resultLabel.text = "Игрок \(name) завершил игру с количеством печенья: \(cookies)"
        
        let action1 = UIAction(title: "Да!") {_ in
            print("\(self.name) хорошо оценил игру")
        }
        let action2 = UIAction(title: "Не очень") {_ in
            print("\(self.name) плохо оценил игру")
        }
        
        let surveyMenu = UIMenu(title: "Понравилась ли вам игра?", children: [action1, action2])
        surveyButton.menu = surveyMenu
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let avc = UIActivityViewController(activityItems: [resultLabel.text as Any], applicationActivities: nil)
        present(avc, animated: true)
    }
    
    
    @IBAction func surveyEasterEgg() {
        EasterEggLabel.isHidden = false
        easterEggImage.isHidden = false
        chooseImageButton.isHidden = false
    }
    
    @IBAction func chooseImageButtonPressed() {
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
        }

        func openImagePicker(sourceType: UIImagePickerController.SourceType) {
            // Открываем UIImagePickerController с указанным источником
            imagePicker.showImagePicker(in: self, sourceType: sourceType) { image in
                self.easterEggImage.image = image
            }
        }
    
}
