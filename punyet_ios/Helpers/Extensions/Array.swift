//
//  Array.swift
//  punyet_ios
//
//  Created by Adrian Prieto Villena on 26/6/24.
//

import Foundation

extension Array  {
    mutating func moveFirstElementToEnd() {
        guard !isEmpty else { return }
        let firstElement = removeFirst()
        append(firstElement)
    }
}
