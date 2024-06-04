//
//  ListPlayersProtocols.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

protocol ListPlayersViewModelProtocol {
    var gameState: GameState { get }
    var sections: [TypeCell] { get }
    func configureData()
    func getPlayers(are statePlayer: StatePlayer) -> [Player]
    func getTotalCoins() -> Int
    func goToCoinSelection()

}

protocol ListPlayersRouterProtocol {
    func goToCoinSelection(players: [Player])
}
