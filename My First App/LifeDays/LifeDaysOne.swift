//
//  FirstViewController.swift
//  LifeDays
//
//  Created by Артем Табенский on 06.03.2024.
//

import UIKit

class LifeDaysOne: UIViewController {

    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var resultButton: UIButton!
    private var firstdate = Date.now
    private var seconddate = Date.now
    private var difference = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction private func unwindSegue(unwindSegue:UIStoryboardSegue) { }

    @IBAction private func fisrtDatePicker(_ sender: UIDatePicker) {
        firstdate = sender.date
    }
    
    @IBAction private func secondDatePicker(_ sender: UIDatePicker) {
        seconddate = sender.date
    }
    @IBAction private func resultButtonTapped() {
        difference = Calendar.current.dateComponents([.day], from: firstdate, to: seconddate).day ?? 0000
        resultLabel.text = "\(difference) дней"
    }
}
