//
//  AddPlayerTableViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var addPlayerTextField: UITextField!
    @IBOutlet weak var addPlayerLabel: UILabel!
    @IBOutlet weak var addPlayerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //TODO: - Delegate
    func setupCell() {
        addPlayerView.layer.cornerRadius = 6
        addPlayerView.backgroundColor = .yaleBlue
        addPlayerLabel.textColor = .white
        addPlayerLabel.text = "Añadir"
        addPlayerLabel.font = .robotoMedium(with: 16)
        addPlayerTextField.textColor = .yaleBlue
        addPlayerTextField.font = .robotoRegular(with: 16)
    }
    
}
