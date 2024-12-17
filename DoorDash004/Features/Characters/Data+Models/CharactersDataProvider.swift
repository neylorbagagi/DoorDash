//
//  CharactersDataProvider.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import Combine

protocol CharactersDataProviding {
    var dataModel: AnyPublisher<CharactersDataModel, Never> { get }
    func getData()
    func getCharacterFrom(id: Int) -> CharacterDataModel?
}

final class CharactersDataProvider: CharactersDataProviding {
    var dataModel: AnyPublisher<CharactersDataModel, Never> {
        dataSubject.eraseToAnyPublisher()
    }
    
    private let dataSubject: CurrentValueSubject<CharactersDataModel, Never>
    
    init(initialValue: CharactersDataModel) {
        dataSubject = CurrentValueSubject<CharactersDataModel, Never>(initialValue)
    }
    
    func getData() {
        if let path = Bundle.main.url(forResource: "json", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let decodedData = try JSONDecoder().decode(CharactersAPIDataModel.self, from: data)
                dataSubject.send(CharactersDataModel(characters: decodedData.results))
            } catch {
                print(error)
            }
        }
    }
    
    func getCharacterFrom(id: Int) -> CharacterDataModel? {
        dataSubject.value.characters.first(where: { $0.id == id })
    }
}
