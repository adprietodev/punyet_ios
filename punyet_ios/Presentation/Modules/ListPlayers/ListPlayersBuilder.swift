//
//  ListPlayersBuilder.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

class ListPlayersBuilder {
    func build(gameState: GameState) -> ListPlayersViewController {
        let viewController = ListPlayersViewController()
        let router = ListPlayersRouter(viewController: viewController)
        viewController.viewModel = ListPlayersViewModel(router: router, gameState: gameState)
        return viewController
    }
}
