//
//  SeventhTableViewController.swift
//  My First App
//
//  Created by Артем Табенский on 13.03.2024.
//

import UIKit

class Contacts2TableViewController: UITableViewController {
    
    private var people: [Person] = []
    private var peopleLoader = PeopleLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleLoader.loadContacts(arrayToFill: &people)
    }
    
    @IBAction private func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "Введите имя и номер",
            message: "Введите имя и номер контакта, который хотите добавить",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "Имя"
        }
        alertController.addTextField() { textField in
            textField.placeholder = "Номер"
        }
        let action = UIAlertAction(title: "Добавить", style: .default) { _ in
            let name = alertController.textFields![0].text!
            let number = alertController.textFields![1].text!
            self.people.append(Person(name: name, phoneNumber: number, image: UIImage(systemName: "person")))
            self.tableView.reloadData()
        }
        alertController.addAction(action)
        let action2 = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(action2)
        present(alertController, animated: true)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonViewCell
        
        let person = people[indexPath.row]
        
        cell.initCell(with: person)
        
        return cell
    }
}

// MARK: - Extensions

extension Contacts2TableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = people[indexPath.row].name
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .normal, title: "Повысить") { _, _, completion in
            //tableView.moveSection(indexPath.row, toSection: indexPath.row + 1)
            self.people[indexPath.row].name += " ⚜️"
            self.tableView.reloadData()
            print("Повышение - \(self.people[indexPath.row].name)")
            completion(true)
        }
        
        let action2 = UIContextualAction(style: .normal, title: "Понизить") { _, _, completion in
            if self.people[indexPath.row].name.last == "⚜️"{
                self.people[indexPath.row].name = String(self.people[indexPath.row].name.dropLast())
                self.people[indexPath.row].name = String(self.people[indexPath.row].name.dropLast())
                self.tableView.reloadData()
            }
            print("Понижение - \(self.people[indexPath.row].name)")
            completion(true)
        }
        
        action1.backgroundColor = UIColor.systemBlue
        return UISwipeActionsConfiguration(actions: [action1, action2])
    }
    
}
