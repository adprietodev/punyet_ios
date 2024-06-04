//
//  NumberCollectionViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var numberContainerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!

    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            numberContainerView.backgroundColor = isSelected ? .royalAzure : .white
            numberLabel.textColor = isSelected ? .white : .royalAzure
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(numberCoin: NumberCoin) {
        numberLabel.text = "\(numberCoin.number)"
        numberLabel.textColor = .royalAzure
        numberLabel.layer.opacity = numberCoin.isSelected ? 0.5 : 1
        numberLabel.font = .robotoBold(with: 32)
        numberContainerView.layer.borderColor  = numberCoin.isSelected ? UIColor.customLightGray.cgColor : UIColor.royalAzure.cgColor
        numberContainerView.backgroundColor = numberCoin.isSelected ? .customLightGray : .white
        numberContainerView.layer.cornerRadius = 6
        numberContainerView.layer.borderWidth = numberCoin.isSelected ? 0 : 1
    }
}
