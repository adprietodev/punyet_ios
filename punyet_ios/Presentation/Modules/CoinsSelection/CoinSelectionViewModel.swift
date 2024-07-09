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
    var indexNextPlayer: Int = 0
    var currentIndexPlayer: Int = 0

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

    func checkCoinIsSelected(number: Int) -> Bool {
        numbersCoin.filter({ $0.number == number })[0].isSelected
    }

    func getNamePlayer() -> String {
        while indexNextPlayer < players.count {
            let player = players[indexNextPlayer]
            if player.statePlayer == .playing {
                currentIndexPlayer = indexNextPlayer
                indexNextPlayer += 1
                return player.name
            }
            indexNextPlayer += 1
        }
        return ""
    }

    func setTotalNumberCoinsAtCurrentPlayer(number: Int) {
        if players[currentIndexPlayer].totalNumberCoins != nil {
            for (index,numberCoin) in numbersCoin.enumerated() {
                if numberCoin.number == players[currentIndexPlayer].totalNumberCoins {
                    numbersCoin[index].isSelected = false
                }
            }
            players[currentIndexPlayer].totalNumberCoins = nil
        }
        numbersCoin[number].isSelected = true
        players[currentIndexPlayer].totalNumberCoins = number
        
    }

    func isLastPlayerInGame(_ player: String) -> Bool {
        player == players.filter({$0.statePlayer == .playing}).last?.name
    }

    func goToTotalCoins() {
        router.goToTotalCoins(players: players)
    }
}
