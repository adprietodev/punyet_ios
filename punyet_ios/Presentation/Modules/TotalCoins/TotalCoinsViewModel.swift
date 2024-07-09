//
//  TotalCoinsViewModel.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 5/6/24.
//

import Foundation

class TotalCoinsViewModel: TotalCoinsViewModelProtocol {
    let router: TotalCoinsRouterProtocol
    var players: [Player]

    init(router: TotalCoinsRouterProtocol, players: [Player]) {
        self.router = router
        self.players = players
    }

    // MARK: - Functions
    func isAWinner(number: Int) -> Player? {
        guard let winnerIndex = players.firstIndex(where: { $0.totalNumberCoins == number && $0.statePlayer == .playing }) else {
            return nil
        }
        players[winnerIndex].statePlayer = .classified
        players[winnerIndex].totalNumberOfCoinsWasClassified = players[winnerIndex].totalNumberCoins
        return players[winnerIndex]
    }

    func goToListPlayers() {
        let gameState = players.filter({$0.statePlayer == .playing}).count == 1 ? GameState.finish : GameState.playing
        players.forEach { $0.clearTotalNumberCoins() }
        router.goToListPlayers(gameState: gameState)
    }
}
