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
    
    var gameResultsArray: Array<GameResult>?
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var thankyouLabel: UILabel!
    
    let storage = UserDefaults.standard
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        
        if let savedData = UserDefaults.standard.data(forKey: "cookieClickerResults") {
            do {
                let decodedResults = try JSONDecoder().decode([GameResult].self, from: savedData)
                gameResultsArray = decodedResults.sorted(by: { $0.score > $1.score })
                print("Результаты загружены: \(decodedResults)")
            } catch {
                print("Ошибка при декодировании: \(error.localizedDescription)")
            }
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
        
        tableView.layoutMargins = .init(top: 0.0, left: 25, bottom: 0.0, right: 25)
        //tableView.separatorInset = tableView.layoutMargins
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let avc = UIActivityViewController(activityItems: [resultLabel.text as Any], applicationActivities: nil)
        present(avc, animated: true)
    }
    
}

// MARK: -

extension CookieResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameResultsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ResultTableCell.reuseIDentifier,
            for: indexPath
        ) as? ResultTableCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = gameResultsArray?[indexPath.row].name
        cell.countLabel.text = "\(gameResultsArray?[indexPath.row].score ?? 404)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(
            title: "\(gameResultsArray?[indexPath.row].name ?? "No Name")",
            message: "\(gameResultsArray?[indexPath.row].date.formatted(date: .numeric, time: .standard) ?? "No Date") \n  Результат: \(gameResultsArray?[indexPath.row].score ?? 0)",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
