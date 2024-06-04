//
//  CoinSelectionRouter.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 4/6/24.
//

import Foundation

class CoinSelectionRouter: CoinSelectionRouterProtocol {
    let viewController: CoinSelectionViewController

    init(viewController: CoinSelectionViewController) {
        self.viewController = viewController
    }
}
