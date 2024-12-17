//
//  CharactersViewModel.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import Combine

final class CharactersViewModel {
    
    var displayStateSubject: Published<CharactersDisplayState>.Publisher {
        $displayState
    }
    
    @Published private var displayState: CharactersDisplayState
    private var cancellables = Set<AnyCancellable>()
    private let dataProvider: CharactersDataProviding
    
    init(dataProvider: CharactersDataProviding) {
        self.dataProvider = dataProvider
        self.displayState = .emptyDisplayState()
        
        binding()
    }
    
    private func binding() {
        dataProvider.dataModel.sink { [weak self] data in
            self?.updateDisplayState(data: data)
        }.store(in: &cancellables)
    }
    
    func updateDisplayState(data: CharactersDataModel) {
        let newState = CharactersDisplayStateBuilder.build(from: data)
        displayState = newState
    }
}
