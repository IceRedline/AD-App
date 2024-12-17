//
//  ViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 04.03.2024.
//

import UIKit

class LifeDaysTwo: UIViewController {
    
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    private var numberOfDays = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultButton.layer.cornerRadius = 12
    }

    @IBAction func datePicker(_ sender: UIDatePicker) {
        if sender.date <= Date.now {
            if daysLabel.text == "Ты что, в будущем живешь?" {
                daysLabel.text = "Ты наслаждаешься жизнью уже ... дней!"
            }
            let range = sender.date..<Date.now
            numberOfDays = range.formatted(.components(style: .wide, fields: [.day]).locale(Locale(identifier: "ru")))
        }
        else {
            daysLabel.text = "Ты что, в будущем живешь?"
        }
    }
    @IBAction func resultButtonTapped() {
            daysLabel.text = "Ты наслаждаешься жизнью уже \(numberOfDays)!"
    }
    
    
}

