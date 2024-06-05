//
//  PlayerTableViewCell.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var namePlayerLabel: UILabel!
    @IBOutlet weak var removePlayerImageView: UIImageView!
    @IBOutlet weak var removePlayerView: UIView!
    @IBOutlet weak var outCoinLabel: UILabel!

    // MARK: - Properties
    weak var delegate: PlayerTableViewCellDelegate?
    var indexPlayer: Int = 0

    // MARK: - IBActions
    @IBAction func removePlayer(_ sender: Any) {
        delegate?.removePlayer(with: indexPlayer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(player: Player, indexPlayer: Int, statePlayer: StatePlayer, gameState: GameState, delegate: PlayerTableViewCellDelegate) {
        self.delegate = delegate
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
