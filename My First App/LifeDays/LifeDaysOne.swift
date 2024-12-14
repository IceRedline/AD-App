//
//  FirstViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 06.03.2024.
//

import UIKit

class LifeDaysOne: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    var firstdate = Date.now
    var seconddate = Date.now
    var difference = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func unwindSegue(unwindSegue:UIStoryboardSegue) { }

    @IBAction func fisrtDatePicker(_ sender: UIDatePicker) {
        firstdate = sender.date
    }
    
    @IBAction func secondDatePicker(_ sender: UIDatePicker) {
        seconddate = sender.date
    }
    @IBAction func resultButtonTapped() {
        difference = Calendar.current.dateComponents([.day], from: firstdate, to: seconddate).day ?? 0000
        resultLabel.text = "\(difference) дней"
    }
}
