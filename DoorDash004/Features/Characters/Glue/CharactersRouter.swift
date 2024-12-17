//
//  CharactersRouter.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import UIKit

final class CharactersRouter {
    weak var viewController: UIViewController?
//    private CharacterDetailBuilder = CharacterDetailBuildable
    
    func presentDetails(character: CharacterDataModel) {
        let navigationController = viewController?.navigationController
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.title = character.name
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
