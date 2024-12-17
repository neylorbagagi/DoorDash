//
//  CharactersDisplayState.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation

struct CharactersDisplayState {
    let navigationTitle: String
    let charactersCells: [CharactersCellDisplayState]
}

struct CharactersCellDisplayState {
    let id: Int
    let name: String
    var image: String?
}

extension CharactersDisplayState {
    static func emptyDisplayState() -> CharactersDisplayState {
        CharactersDisplayState(
            navigationTitle: "",
            charactersCells: [])
    }
}
