//
//  Player.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 3/6/24.
//

import Foundation

enum StatePlayer {
    case playing
    case cassified
}

class Player {
    let name: String
    var totalNumberCoins: Int?
    var statePlayer: StatePlayer
    var totalNumberOfCoinsWasClassified: Int?

    init(name: String, statePlayer: StatePlayer) {
        self.name = name
        self.totalNumberCoins = nil
        self.statePlayer = statePlayer
        self.totalNumberOfCoinsWasClassified = nil
    }
}
