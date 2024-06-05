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
    var showAlertExistingPlayer: (() -> Void)?
    var reloadInGameSectionTable: (() -> Void)?
    var reloadTotalCoinSectionTable: (() ->  Void)?
    var enabledOrDisabledPlayButton: ((Bool) -> Void)?

    init(router: ListPlayersRouterProtocol, gameState: GameState) {
        self.router = router
        self.gameState = gameState
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

    func goToCoinSelection() {
        router.goToCoinSelection(players: players)
    }

    func getLoser() -> String {
        guard let nameLoser = players.first(where: {$0.statePlayer == .playing})?.name else {
            return ""
        }
        return nameLoser
    }

    func resetGame() {
        gameState = .addPlayers
        configureData()
        players.forEach({
            $0.statePlayer = .playing
            $0.totalNumberCoins = nil
            $0.totalNumberOfCoinsWasClassified = nil
        })
    }
}

extension ListPlayersViewModel: AddPlayerTableViewCellDelegate, PlayerTableViewCellDelegate {
    func addPlayer(with name: String) {
        !players.contains(where: {$0.name.lowercased() == name.lowercased()}) ? players.append(Player(name: name, statePlayer: .playing)) : showAlertExistingPlayer?()
        reloadInGameSectionTable?()
        reloadTotalCoinSectionTable?()
        players.count >= 2 ? enabledOrDisabledPlayButton?(true) : enabledOrDisabledPlayButton?(false)
    }
    
    func removePlayer(with index: Int) {
        players.remove(at: index)
        reloadInGameSectionTable?()
        reloadTotalCoinSectionTable?()
        players.count < 2 ? enabledOrDisabledPlayButton?(false) : enabledOrDisabledPlayButton?(true)
    }
}
