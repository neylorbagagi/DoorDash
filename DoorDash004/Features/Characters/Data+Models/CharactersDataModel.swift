//
//  CharactersDataModel.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation

struct CharactersDataModel {
    let characters: [CharacterDataModel]
}

struct CharacterDataModel: Decodable {
    let id: Int
    let name: String
    var image: String?
}

struct CharactersAPIDataModel: Decodable {
    let info: CharactersAPIMetaDataModel
    let results: [CharacterDataModel]
}

struct CharactersAPIMetaDataModel: Decodable {
    let count: Int
    let pages: Int
    var next: String?
    var prev: String?
}

extension CharactersDataModel {
    static func emptyDataModel() -> CharactersDataModel {
        CharactersDataModel(characters: [])
    }
}
