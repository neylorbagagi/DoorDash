//
//  CharactersViewController.swift
//  DoorDash004
//
//  Created by Neylor Wendel Silva Bagagi on 17/12/24.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {

    private let viewModel: CharactersViewModel
    private let eventManager: CharactersEventManager
    private var displaState: CharactersDisplayState
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            CharactersTableCellView.self,
            forCellReuseIdentifier: CharactersTableCellView.identifier)
        return tableView
    }()
    
    init(viewModel: CharactersViewModel, eventManager: CharactersEventManager) {
        self.viewModel = viewModel
        self.eventManager = eventManager
        self.displaState = .emptyDisplayState()
        
        super.init(nibName: nil, bundle: nil)
        
        binding()
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        eventManager.eventSubject.send(.viewDidLoad)
    }
    
    private func binding() {
        viewModel.displayStateSubject.sink { [weak self] displayState in
            self?.updateDisplayState(state: displayState)
        }.store(in: &cancellables)
    }
    
    private func setupView() {
        view.addSubview(tableView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
        ])
    }
    
    private func updateDisplayState(state: CharactersDisplayState) {
        displaState = state
        title = displaState.navigationTitle
        tableView.reloadData()
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayState = displaState.charactersCells[indexPath.row]
        eventManager.eventSubject.send(.didSelectCharacter(id: displayState.id))
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displaState.charactersCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableCellView.identifier, for: indexPath) as? CharactersTableCellView else {
            return UITableViewCell()
        }
        
        let displayState = displaState.charactersCells[indexPath.row]
        cell.update(displayState: displayState)
        
        return cell
    }
}

#Preview {
    let dataProvider =  CharactersDataProvider(initialValue: .emptyDataModel())
    return CharactersViewController(
        viewModel: CharactersViewModel(dataProvider: dataProvider),
        eventManager: CharactersEventManager(dataProvider: dataProvider, router: CharactersRouter()))
}
