//
//  CharactersDisplayStateBuilder.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation

final class CharactersDisplayStateBuilder {
    static func build(from data: CharactersDataModel) -> CharactersDisplayState {
        CharactersDisplayState(
            navigationTitle: "Rick & Morty",
            charactersCells: Self.makeCharactersCellDisplayState(data: data.characters))
    }
    
    private static func makeCharactersCellDisplayState(data: [CharacterDataModel]) -> [CharactersCellDisplayState] {
        data.map {
            CharactersCellDisplayState(
                id: $0.id,
                name: $0.name,
                image: $0.image)
        }
    }
}
