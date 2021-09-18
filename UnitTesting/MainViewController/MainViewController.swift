//
//  MainViewController.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import UIKit

protocol MainViewControllerInput: AnyObject {
    func reloadTableView()
    func handleError(_ error: Error)
}

final class MainViewController: UIViewController {
    
    public var presenter: MainViewPresenterInput?
    
    private let selfView = MainView()
    
    override func loadView() {
        view = selfView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        presenter?.loadAlbums()
    }
    
    private func setupController() {
        title = "Albums"
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
        presenter?.didSelectAlbum(with: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumCell.identifier,
            for: indexPath) as? AlbumCell else { return UITableViewCell() }
        cell.setTitle(presenter?.getAlbumTitle(for: indexPath.row) ?? "")
        return cell
    }
}

// MARK: - MainViewControllerInput

extension MainViewController: MainViewControllerInput {
    
    func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error",
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        selfView.tableView.reloadData()
    }
}
