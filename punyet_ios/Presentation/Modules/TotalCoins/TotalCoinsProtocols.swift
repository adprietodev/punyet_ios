//
//  TotalCoinsProtocols.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 5/6/24.
//

import Foundation

protocol TotalCoinsViewModelProtocol {
    func isAWinner(number: Int) -> Player?
    func goToListPlayers()
}

protocol TotalCoinsRouterProtocol {
    func goToListPlayers(gameState: GameState)
}
