//
//  AlbumViewPresenter.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import Foundation

protocol AlbumViewPresenterInput {
    //    func prefetchRows(at indexPaths: [IndexPath])
    //    func cancelPrefetchingForRows(at indexPaths: [IndexPath])
}

protocol AlbumViewPresenterOutput: AnyObject {
    
}

final class AlbumViewPresenter {
    
    public weak var output: AlbumViewPresenterOutput?
    
    private weak var controller: AlbumViewControllerInput?
    
    private let album: Album
    
    init(controller: AlbumViewControllerInput, album: Album) {
        self.controller = controller
        self.album = album
    }
    
    //    public func prefetchRows(at indexPaths: [IndexPath]) {
    //        for indexPath in indexPaths {
    //            let albom = albums[indexPath.row]
    //            imageService.downloadImage(for: albom.thumbnailUrl,
    //                                          and: indexPath) { [weak self] result in
    //                switch result {
    //                case .success((let image, let indexPath)):
    //                    self?.albums[indexPath.row].image = image
    //                case .failure(_):
    //                    break
    //                }
    //            }
    //        }
    //    }
    //
    //    public func cancelPrefetchingForRows(at indexPaths: [IndexPath]) {
    //        for indexPath in indexPaths {
    //            imageService.stopDownloadImage(for: indexPath)
    //        }
    //    }
}

extension AlbumViewPresenter: AlbumViewPresenterInput {
    
}
