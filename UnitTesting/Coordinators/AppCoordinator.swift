//
//  AppCoordinator.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }
    
    public func start() {
        let viewController = MainViewController()
        let presenter = MainViewPresenter(controller: viewController)
        presenter.output = self
        viewController.presenter = presenter
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}


// MARK: - MainViewPresenterOutput

extension AppCoordinator: MainViewPresenterOutput {
    
    func displayAlbumPhotos(_ album: Album) {
        let albumViewController = AlbumViewController()
        let albumViewPresenter = AlbumViewPresenter(controller: albumViewController, album: album)
        albumViewController.presenter = albumViewPresenter
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}
