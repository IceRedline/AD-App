//
//  Model.swift
//  My First App
//
//  Created by Артем Табенский on 04.06.2024.
//
// ВОСПОМОГАТЕЛЬНЫЙ КЛАСС

import Foundation

class ToDoItem: Codable {
    
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(title: String, date: Date, isCompleted: Bool) {
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}

class Model {
    
    var items: [ToDoItem] = []
    
    init() {
        loadData()
    }
    
    func addItem(title: String) {
        items.append(ToDoItem(title: title, date: Date(), isCompleted: false))
        saveData()
    }
    
    func deleteItem(atIndex index: Int) {
        items.remove(at: index)
        saveData()
    }
    
    func renameItem(atIndex index: Int, newTitle: String) {
        items[index].title = newTitle
        saveData()
    }
    
    func toggleItem(atIndex index: Int) {
        items[index].isCompleted.toggle()
        saveData()
    }
    
    let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appending(path: "database.data") // стандартная папка в песочнице приложения
    
    private func saveData() {
        print(url)
        let data = try? JSONEncoder().encode(items)
        try? data?.write(to: url)
    }
    
    private func loadData() {
        if let data = try? Data(contentsOf: url) {
            items = (try? JSONDecoder().decode([ToDoItem].self, from: data)) ?? []
        }
    }
}
