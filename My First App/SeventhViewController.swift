//
//  SeventhViewController.swift
//  My First App
//
//  Created by Артем Табенский on 10.03.2024.
//

import UIKit

class SeventhViewController: UIViewController {

    var names = ["Artyom", "Yaroslav", "George"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Введите имя", message: "Введите имя контакта, который хотите добавить", preferredStyle: .alert)
        alertController.addTextField() { textField in
            textField.placeholder = "Имя"
        }
        let action = UIAlertAction(title: "Ок", style: .default) { _ in
            let name = alertController.textFields![0].text!
            self.names.append("\(name)")
            self.tableView.reloadData()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
        
    }
}

extension SeventhViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = names[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
}

extension SeventhViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = names[indexPath.row]
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .normal, title: "Повысить") { _, _, completion in
            //tableView.moveSection(indexPath.row, toSection: indexPath.row + 1)
            self.names[indexPath.row] += " ⚜️"
            self.tableView.reloadData()
            print("leading 1 - \(self.names[indexPath.row])")
            completion(true)
        }
        let action2 = UIContextualAction(style: .normal, title: "Понизить") { _, _, completion in
            if self.names[indexPath.row].last == "⚜️"{
                self.names[indexPath.row] = String(self.names[indexPath.row].dropLast())
                self.names[indexPath.row] = String(self.names[indexPath.row].dropLast())
                self.tableView.reloadData()
            }
            print("leading 2 - \(self.names[indexPath.row])")
            completion(true)
        }
        
        action1.backgroundColor = UIColor.systemBlue
        return UISwipeActionsConfiguration(actions: [action1, action2])
    }
    
}
