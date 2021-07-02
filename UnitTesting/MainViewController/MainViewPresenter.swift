//
//  MainViewPresenter.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation

protocol MainViewPresenterInput: AnyObject {
    var numberOfRowsInSection: Int { get }
    func loadAlmums()
    func prefetchRows(at indexPaths: [IndexPath])
    func cancelPrefetchingForRows(at indexPaths: [IndexPath])
}

class MainViewPresenter {
    
    private var albums: [Album] = []
    private let controller: MainViewControllerInput
    private let imageService = ImageService.shared
    
    
    init(controller: MainViewControllerInput) {
        self.controller = controller
    }
}

// MARK: - MainViewPresenterInput

extension MainViewPresenter: MainViewPresenterInput {
    
    public func loadAlmums() {
        
    }
    
    public func prefetchRows(at indexPath: [IndexPath]) {
        for indexPath in indexPath {
            let albom = albums[indexPath.row]
            imageService.downloadImage(for: albom.thumbnailUrl,
                                          and: indexPath) { [weak self] result in
                switch result {
                case .success((let image, let indexPath)):
                    self?.albums[indexPath.row].image = image
                case .failure(_):
                    break
                }
            }
        }
    }
    
    public func cancelPrefetchingForRows(at indexPath: [IndexPath]) {
        for indexPath in indexPath {
            imageService.stopDownloadImage(for: indexPath)
        }
    }
    
    public var numberOfRowsInSection: Int {
        return albums.count
    }
}
