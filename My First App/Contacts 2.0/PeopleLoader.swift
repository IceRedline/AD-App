//
//  PeopleLoader.swift
//  My First App
//
//  Created by Артем Табенский on 16.01.2025.
//

import UIKit

class PeopleLoader {
    func loadContacts(arrayToFill: inout Array<Person>) {
        arrayToFill = [Person(name: "Артём", phoneNumber: "+7 (906) 093-22-50", image: UIImage(named: "Artyom.jpeg")),
                       Person(name: "Ярослав", phoneNumber: "+7 (963) 630-63-29", image: UIImage(named: "An.jpg")),
                       Person(name: "Дмитрий", phoneNumber: "+7 (925) 380-18-59", image: UIImage(named: "Dima.jpg")),
                       Person(name: "Георгий", phoneNumber: "+7 (903) 397-14-31", image: UIImage(named: "george.jpg"))]
    }
}
