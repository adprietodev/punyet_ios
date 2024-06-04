//
//  NumberCollectionViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberContainerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(numberCoin: NumberCoin) {
        numberLabel.text = "\(numberCoin.number)"
        numberLabel.textColor = .yaleBlue
        numberLabel.font = .robotoBold(with: 32)
        numberContainerView.layer.borderColor  = UIColor.yaleBlue.cgColor
        numberContainerView.layer.cornerRadius = 6
        numberContainerView.layer.borderWidth = 1
    }
}
