//
//  CoinSelectionBuilder.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import Foundation

class CoinSelectionBuilder {
    func build(players: [Player]) -> CoinSelectionViewController {
        let viewController = CoinSelectionViewController()
        let router = CoinSelectionRouter(viewController: viewController)
        viewController.viewModel = CoinSelectionViewModel(router: router, players: players)
        return viewController
    }
}
