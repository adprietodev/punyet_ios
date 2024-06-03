//
//  PlayerTableViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var namePlayerLabel: UILabel!
    @IBOutlet weak var removePlayerImageView: UIImageView!
    @IBOutlet weak var removePlayerView: UIView!
    @IBOutlet weak var outCoinLabel: UILabel!
    
    var indexPlayer: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(player: Player, indexPlayer: Int, statePlayer: StatePlayer, gameState: GameState) {
        namePlayerLabel.text = player.name
        namePlayerLabel.font = .robotoRegular(with: 16)
        namePlayerLabel.textColor = .yaleBlue
        self.indexPlayer = indexPlayer
        removePlayerView.isHidden = !(gameState == .addPlayers)
        outCoinLabel.isHidden = (statePlayer == .playing)
        if let classifiedCoin = player.totalNumberOfCoinsWasClassified {
            outCoinLabel.text = "\(classifiedCoin)"
        }
    }
    
}
