//
//  PersonModel.swift
//  My First App
//
//  Created by Артем Табенский on 17.12.2024.
//

import UIKit

class Person {
    var name: String = ""
    var phoneNumber: String = ""
    var image: UIImage?
    init(name: String, phoneNumber: String, image: UIImage? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
    }
}
