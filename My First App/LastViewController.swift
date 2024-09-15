//
//  LastViewController.swift
//  My First App
//
//  Created by Артем Табенский on 23.03.2024.
//

import UIKit

class LastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func BackButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
