//
//  MainViewPresenter.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation

protocol MainViewPresenterInput: AnyObject {
    func loadAlbums()
    func getAlbumTitle(for index: Int) -> String
    func didSelectAlbum(with index: Int)
    var numberOfRowsInSection: Int { get }
    init(controller: MainViewControllerInput)
}

protocol MainViewPresenterOutput: AnyObject {
    func displayAlbumPhotos(_ album: Album)
}

final class MainViewPresenter {
    
    public weak var output: MainViewPresenterOutput?
    
    private var albums: [Album] = []
    private weak var controller: MainViewControllerInput?    
    
    init(controller: MainViewControllerInput) {
        self.controller = controller
    }
}

// MARK: - MainViewPresenterInput

extension MainViewPresenter: MainViewPresenterInput {
    
    public func loadAlbums() {
        AlbumService.shared.getAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.controller?.reloadTableView()
                case .failure(let error):
                    self?.controller?.handleError(error)
                }
            }
        }
    }
    
    public func getAlbumTitle(for index: Int) -> String {
        return albums[index].title
    }
    
    public func didSelectAlbum(with index: Int) {
        output?.displayAlbumPhotos(albums[index])
    }
      
    public var numberOfRowsInSection: Int {
        return albums.count
    }
}
