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
    
    var gameResults: Array<GameResult>?
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var thankyouLabel: UILabel!
    
    let storage = UserDefaults.standard
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        
        if let savedData = UserDefaults.standard.data(forKey: "cookieClickerResults"),
           let decodedResults = try? JSONDecoder().decode([GameResult].self, from: savedData) {
            gameResults = decodedResults.sorted(by: { $0.score > $1.score })
            print("Результаты загружены: \(decodedResults)")
        } else {
            print("Не удалось загрузить результаты")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let lastResult = storage.string(forKey: "cookieClickerLastResult")
        
        resultLabel.text = "Ваш результат: \(lastResult ?? "resultNotLoaded")"
        
        let action1 = UIAction(title: "Да!") {_ in
            print("\(lastResult ?? "resultNotLoaded") хорошо оценил игру")
            self.thankyouLabel.isHidden = false
            self.surveyButton.isEnabled = false
        }
        let action2 = UIAction(title: "Не очень") {_ in
            print("\(lastResult ?? "resultNotLoaded") плохо оценил игру")
            self.thankyouLabel.isHidden = false
            self.surveyButton.isEnabled = false
        }
        
        let surveyMenu = UIMenu(title: "Понравилась ли вам игра?", children: [action1, action2])
        surveyButton.menu = surveyMenu
        surveyButton.showsMenuAsPrimaryAction = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let avc = UIActivityViewController(activityItems: [resultLabel.text as Any], applicationActivities: nil)
        present(avc, animated: true)
    }
    
    
    @IBAction func surveyEasterEgg() {
        
    }
}


extension CookieResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "\(gameResults?[indexPath.row].date ?? "No Date") - \(gameResults?[indexPath.row].name ?? "No Name") - \(gameResults?[indexPath.row].score ?? 0)"
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = "\(gameResults?[indexPath.row].date ?? "No Date") - \(gameResults?[indexPath.row].name ?? "No Name") - \(gameResults?[indexPath.row].score ?? 0)"
    }
    
}
