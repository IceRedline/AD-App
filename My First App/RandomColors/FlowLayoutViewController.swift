//
//  FloawLayoutViewController.swift
//  My First App
//
//  Created by Артем Табенский on 09.04.2025.
//

import UIKit

class RandomColorsViewController: UIViewController {
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var collectionService: RandomColorsCollectionService?
    var addButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //layout.scrollDirection = .horizontal
        
        let params = GeometricParams(cellCount: 3, leftInset: 10, rightInset: 10, cellSpacing: 10)
        collectionService = RandomColorsCollectionService(using: params)
        collectionService?.viewController = self
        
        collection.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collection.dataSource = collectionService
        collection.delegate = collectionService
        collection.reloadData()
        collection.backgroundColor = .white
        collection.layer.cornerRadius = 16
        
        // Обратите внимание, что экземпляр helper удерживается по weak ссылке.
        addButton = UIButton(type: .roundedRect, primaryAction: UIAction(title: "Add color", handler: { [weak collectionService] _ in
            collectionService?.add()
        }))
        addButton?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        activateConstraints()
    }
    
    func activateConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        addButton?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        view.addSubview(addButton!)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton!.heightAnchor.constraint(equalToConstant: 30),
            addButton!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collection.bottomAnchor.constraint(equalTo: addButton!.topAnchor, constant: -16),
        ])
    }
}
