//
//  SixthViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.03.2024.
//

import UIKit

class CookieResultsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var gameResults: Array<String>?
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var EasterEggLabel: UILabel!
    @IBOutlet weak var easterEggImage: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    
    let storage = UserDefaults.standard
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        
        gameResults = storage.stringArray(forKey: "cookieClickerResults")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(UserDefaults.standard.dictionaryRepresentation())
        let lastResult = storage.string(forKey: "cookieClickerLastResult")
        
        resultLabel.text = "Игра завершена! Результат: \(lastResult ?? "resultNotLoaded")"
        
        let action1 = UIAction(title: "Да!") {_ in
            print("\(lastResult ?? "resultNotLoaded") хорошо оценил игру")
        }
        let action2 = UIAction(title: "Не очень") {_ in
            print("\(lastResult ?? "resultNotLoaded") плохо оценил игру")
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
        [EasterEggLabel, easterEggImage, chooseImageButton].forEach() { x in
            x.isHidden = false
        }
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


extension CookieResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = gameResults?[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = gameResults?[indexPath.row]
    }
    
}
