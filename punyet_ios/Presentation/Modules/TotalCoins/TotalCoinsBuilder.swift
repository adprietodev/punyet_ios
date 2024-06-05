//
//  TotalCoinsBuilder.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 5/6/24.
//

import Foundation

class TotalCoinsBuilder {
    func build(players: [Player]) -> TotalCoinsViewController{
        let viewController = TotalCoinsViewController()
        let router = TotalCoinsRouter(viewController: viewController)
        viewController.viewModel = TotalCoinsViewModel(router: router, players: players)
        return viewController
    }
}
