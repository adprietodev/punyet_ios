//
//  CoinSelectionProtocols.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import Foundation

protocol CoinSelectionViewModelProtocol {
    var players: [Player] { get set }
    var numbersCoin: [NumberCoin] { get set }
    func checkCoinIsSelected(number: Int) -> Bool
    func getNamePlayer() -> String
    func setTotalNumberCoinsAtCurrentPlayer(number: Int)
    func isLastPlayerInGame(_ player: String) -> Bool
    func goToTotalCoins()
}

protocol CoinSelectionRouterProtocol {
    func goToTotalCoins(players: [Player])
}
