//
//  ListPlayersViewModel.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

class ListPlayersViewModel: ListPlayersViewModelProtocol {
    // MARK: - Properties
    let router: ListPlayersRouterProtocol
    var gameState: GameState
    var sections = [TypeCell]()
    var players = [Player]()

    init(router: ListPlayersRouterProtocol, gameState: GameState) {
        self.router = router
        self.gameState = gameState
        players = [
            Player(name: "Adrián", statePlayer: .playing),
            Player(name: "Ruben", statePlayer: .playing),
            Player(name: "Miguel", statePlayer: .cassified),
            Player(name: "Demetrio", statePlayer: .playing)
        ]
    }

    //MARK: - Functions
    func configureData() {
        switch gameState {
        case .addPlayers:
            sections = [.addPlayer,.totalCoins,.inGame]
        case .playing:
            sections = [.totalCoins,.inGame,.classified]
        case .finish:
            break
        }
    }

    func getPlayers(are statePlayer: StatePlayer) -> [Player] {
        players.filter({ $0.statePlayer == statePlayer})
    }

    func getTotalCoins() -> Int {
        players.count * 3
    }
}
