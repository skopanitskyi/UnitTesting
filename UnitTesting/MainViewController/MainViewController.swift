//
//  MainViewController.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import UIKit

protocol MainViewControllerInput: AnyObject {
    
}

class MainViewController: UIViewController {
    
    public weak var presenter: MainViewPresenterInput?
    
    private let selfView = MainView()
    
    override func loadView() {
        view = selfView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        selfView.tableView.reloadData()
    }
    
    private func setupController() {
        setupSelfView()
    }
    
    private func setupSelfView() {
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath)
        return cell
    }
}

// MARK: - MainViewControllerInput

extension MainViewController: MainViewControllerInput {
    
}
