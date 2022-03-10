//
//  nameCell.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit

class nameCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    var dataViewModel: DataViewModel?
    
    @IBOutlet weak var name: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(dataViewModel: DataViewModel) {
        self.dataViewModel = dataViewModel
        nameTextField.addTarget(self, action: #selector(nameCell.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        dataViewModel?.nameText = textField.text
    }
    
}
