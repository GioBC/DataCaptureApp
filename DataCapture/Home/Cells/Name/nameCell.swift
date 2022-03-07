//
//  nameCell.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit

class nameCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var name: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
