//
//  PersonViewCell.swift
//  My First App
//
//  Created by Артем Табенский on 13.03.2024.
//

import UIKit

class PersonViewCell: UITableViewCell {

    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    var person: Person!
    func initCell(with person: Person) {
        self.person = person
        imagePerson.image = person.image
        labelName.text = person.name
        labelPhone.text = person.phoneNumber
    }
}
