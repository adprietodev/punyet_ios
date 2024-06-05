//
//  TotalCoinsRouter.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 5/6/24.
//

import Foundation

class TotalCoinsRouter: TotalCoinsRouterProtocol {
    let viewController: TotalCoinsViewController

    init(viewController: TotalCoinsViewController) {
        self.viewController = viewController
    }

    func goToListPlayers(gameState: GameState) {
        if let firstViewController = viewController.navigationController?.viewControllers.first(where: { $0 is ListPlayersViewController }) {
            if let listPlayersViewController = firstViewController as? ListPlayersViewController {
                listPlayersViewController.viewModel.gameState = gameState
                viewController.navigationController?.popToViewController(firstViewController, animated: true)
            }
        }
    }
}
