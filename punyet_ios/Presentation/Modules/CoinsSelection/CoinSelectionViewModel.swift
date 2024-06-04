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
        var name = ""
        repeat {
            if players[indexNextPlayer].statePlayer == .playing {
                name = players[indexNextPlayer].name
            }
            if players.count-1 != indexNextPlayer {
                indexNextPlayer += 1
            } else {
                break
            }
        } while players[indexNextPlayer].statePlayer == .cassified
        return name
    }

    func setTotalNumberCoinsAtCurrentPlayer(number: Int) {
        if players[indexNextPlayer-1].totalNumberCoins != nil {
            for (index,numberCoin) in numbersCoin.enumerated() {
                if numberCoin.number == players[indexNextPlayer-1].totalNumberCoins {
                    numbersCoin[index].isSelected = false
                }
            }
            players[indexNextPlayer-1].totalNumberCoins = nil
        }
        numbersCoin[number].isSelected = true
        players[indexNextPlayer-1].totalNumberCoins = number
    }

    func isLastPlayerInGame(_ player: String) -> Bool {
        player == players.filter({$0.statePlayer == .playing}).last?.name
    }
}
