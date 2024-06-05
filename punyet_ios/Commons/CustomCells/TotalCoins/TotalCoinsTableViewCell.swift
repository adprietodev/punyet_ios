//
//  TotalCoinsTableViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import UIKit

class TotalCoinsTableViewCell: UITableViewCell {
    @IBOutlet weak var totalCoinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(totalCoins: Int) {
        totalCoinLabel.text = "\(totalCoins)"
        totalCoinLabel.textColor = .yaleBlue
        totalCoinLabel.font = .robotoMedium(with: 16)
    }
}
