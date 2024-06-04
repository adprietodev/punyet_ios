//
//  CoinSelectionViewModel.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import Foundation

struct NumberCoin {
    let number: Int
    var isSelected: Bool
}

class CoinSelectionViewModel: CoinSelectionViewModelProtocol {
    let router: CoinSelectionRouterProtocol
    var players: [Player]
    var numbersCoin = [NumberCoin]()

    init(router: CoinSelectionRouterProtocol, players: [Player]) {
        self.router = router
        self.players = players
        initNumbersCoin()
    }

    func initNumbersCoin() {
        let countPlayersInGame = players.filter({ $0.statePlayer == .playing }).count
        for number in 0...countPlayersInGame*3 {
            numbersCoin.append(NumberCoin(number: number, isSelected: false))
        }
    }
}
