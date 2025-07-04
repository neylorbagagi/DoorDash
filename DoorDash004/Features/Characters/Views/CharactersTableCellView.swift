//
//  CharactersTableCellView.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import Foundation
import UIKit

final class CharactersTableCellView: UITableViewCell {
    
    static let identifier = "CharactersTableCellView"
    var displayState: CharactersCellDisplayState?
    
    private lazy var nameTextLabel: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, nameTextLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 54),
            avatarImageView.heightAnchor.constraint(equalToConstant: 54),
            avatarImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8),
            avatarImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -8),
            avatarImageView.trailingAnchor.constraint(equalTo: nameTextLabel.leadingAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    func update(displayState: CharactersCellDisplayState) {
        nameTextLabel.text = displayState.name
        
        if let imageString = displayState.image {
            avatarImageView.setImage(from: imageString)
        }
    }
}

#Preview {
    let cell = CharactersTableCellView(style: .default, reuseIdentifier: CharactersTableCellView.identifier)
    cell.update(displayState: CharactersCellDisplayState(
        id: 1,
        name: "Rick",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
    
    return cell
}
