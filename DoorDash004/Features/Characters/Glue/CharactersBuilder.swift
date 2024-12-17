//
//  CharactersBuilder.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import UIKit

protocol CharactersBuildable {
    func build() -> UIViewController
}

final class CharactersBuilder: CharactersBuildable {
    func build() -> UIViewController {
        let dataProvider = CharactersDataProvider(initialValue: .emptyDataModel())
        let router = CharactersRouter()
        let viewModel = CharactersViewModel(dataProvider: dataProvider)
        let eventManager = CharactersEventManager(dataProvider: dataProvider, router: router)
        let viewController = CharactersViewController(
            viewModel: viewModel,
            eventManager: eventManager)
        
        router.viewController = viewController
        return viewController
    }
}
