//
//  CharactersEventManager.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import Combine

enum Event {
    case viewDidLoad
    case didSelectCharacter(id: Int)
}

final class CharactersEventManager {
    let eventSubject = PassthroughSubject<Event, Never>()
    private var dataProvider: CharactersDataProviding
    private var router: CharactersRouter
    private var cancellables = Set<AnyCancellable>()
    
    init(dataProvider: CharactersDataProviding,
         router: CharactersRouter) {
        self.dataProvider = dataProvider
        self.router = router

        binding()
    }
    
    private func binding() {
        self.eventSubject.sink { [weak self] event in
            switch event {
                case .viewDidLoad:
                    self?.dataProvider.getData()
                case .didSelectCharacter(let id):
                    if let character = self?.dataProvider.getCharacterFrom(id: id) {
                        self?.router.presentDetails(character: character)
                    }
            }
        }.store(in: &cancellables)
    }
}
