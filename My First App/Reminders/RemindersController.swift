//
//  RemindersController.swift
//  My First App
//
//  Created by Артем Табенский on 29.05.2024.
//

import UIKit

class RemindersController: UITableViewController {

    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addButtonPushed(_ sender: Any) {
        TextPicker().showTextPicker(in: self) { text in
            self.model.addItem(title: text)
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        
        configuration.text = model.items[indexPath.row].title
        configuration.secondaryText = model.items[indexPath.row].date.formatted()
        
        cell.contentConfiguration = configuration
        
        cell.accessoryType = model.items[indexPath.row].isCompleted ? .checkmark : .none // отчечаем выполненные действия

        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Переименовать") { _, _, completion in
            TextPicker().showTextPicker(in: self) { text in
                self.model.renameItem(atIndex: indexPath.row, newTitle: text)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                completion(true)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in
            self.model.deleteItem(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.toggleItem(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
