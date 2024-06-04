//
//  ListPlayersRouter.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

class ListPlayersRouter: ListPlayersRouterProtocol {
    let viewController: ListPlayersViewController

    init(viewController: ListPlayersViewController) {
        self.viewController = viewController
    }

    func goToCoinSelection(players: [Player]) {
        let coinSelectionViewController = CoinSelectionBuilder().build(players: players)
        viewController.navigationController?.pushViewController(coinSelectionViewController, animated: true)
    }
}
