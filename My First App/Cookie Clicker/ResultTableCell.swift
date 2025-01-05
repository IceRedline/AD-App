//
//  ResultTableCell.swift
//  My First App
//
//  Created by Артем Табенский on 24.12.2024.
//

import UIKit

final class ResultTableCell: UITableViewCell {
    
    // MARK: - @IBOutlet properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // MARK: - Static properties
    
    static let reuseIDentifier = "ResultTableCell"
}
