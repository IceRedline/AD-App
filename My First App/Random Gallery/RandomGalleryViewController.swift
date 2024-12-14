//
//  RandomGalleryViewController.swift
//  My First App
//
//  Created by Артем Табенский on 13.12.2024.
//

import UIKit

class RandomGalleryViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startTextLabel: UILabel!
    @IBOutlet weak var themePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themePicker.dataSource = self
    }
}

extension RandomGalleryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    
}
