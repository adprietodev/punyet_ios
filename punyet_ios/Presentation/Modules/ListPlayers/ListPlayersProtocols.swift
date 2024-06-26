//
//  ListPlayersProtocols.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

protocol ListPlayersViewModelProtocol {
    var gameState: GameState { get set }
    var sections: [TypeCell] { get }
    var showAlertExistingPlayer: (() -> Void)? { get set }
    var reloadInGameSectionTable: (() -> Void)? { get set }
    var reloadTotalCoinSectionTable: (() ->  Void)? { get set }
    var enabledOrDisabledPlayButton: ((Bool) -> Void)? { get set }
    func configureData()
    func getPlayers(are statePlayer: StatePlayer) -> [Player]
    func getTotalCoins() -> Int
    func goToCoinSelection()
    func getLoser() -> String
    func resetGame()
    func changePlayerTurn()
}

protocol ListPlayersRouterProtocol {
    func goToCoinSelection(players: [Player])
}

protocol AddPlayerTableViewCellDelegate: AnyObject{
    func addPlayer(with name: String)
}

protocol PlayerTableViewCellDelegate: AnyObject {
    func removePlayer(with index: Int)
}
