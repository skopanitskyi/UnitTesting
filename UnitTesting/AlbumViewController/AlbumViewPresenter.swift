//
//  AlbumViewPresenter.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import UIKit

protocol AlbumViewPresenterInput {
    var numberOfItemsInSection: Int { get }
    func loadPhotos()
    func loadPhoto(for indexParg: IndexPath)
    func prefetchRows(at indexPaths: [IndexPath])
    func cancelPrefetchingForRows(at indexPaths: [IndexPath])
    func getPhoto(at index: Int) -> Photo
    func getAlbumTitle() -> String
    init(controller: AlbumViewControllerInput, album: Album)
}

final class AlbumViewPresenter {
    
    private weak var controller: AlbumViewControllerInput?
    
    private let imageService = ImageService.shared
    private let filterImageService = FilterImageService.shared
    private let album: Album
    
    private var photos: [Photo] = []
    
    init(controller: AlbumViewControllerInput, album: Album) {
        self.controller = controller
        self.album = album
    }
}

// MARK: AlbumViewPresenterInput

extension AlbumViewPresenter: AlbumViewPresenterInput {
    
    public var numberOfItemsInSection: Int {
        return photos.count
    }
    
    public func loadPhotos() {
        PhotoService.shared.getPhotos(album: album.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    self?.controller?.updateCollectionView()
                case .failure(let error):
                    self?.controller?.handleError(error)
                }
            }
        }
    }
    
    public func getPhoto(at index: Int) -> Photo {
        return photos[index]
    }
    
    public func getAlbumTitle() -> String {
        return album.title
    }
    
    public func loadPhoto(for indexPath: IndexPath) {
        imageService.downloadImage(for: photos[indexPath.row].thumbnailUrl, and: indexPath) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success((let image, _)):
                    self?.photos[indexPath.row].image = image.pngData()
                    self?.controller?.didLoadImage(image, at: indexPath)
                    self?.addBlurEffect(to: image, at: indexPath)
                case .failure(let error):
                    self?.controller?.handleError(error)
                }
            }
        }
    }
    
    public func prefetchRows(at indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let photo = photos[indexPath.row]
            
            guard photo.image == nil else {
                guard let isBlurred = photo.isBlurred,
                      !isBlurred,
                      let data = photo.image,
                      let image = UIImage(data: data) else {
                    continue
                }
                addBlurEffect(to: image, at: indexPath)
                continue
            }
            
            imageService.downloadImage(for: photo.thumbnailUrl,
                                          and: indexPath) { [weak self] result in
                switch result {
                case .success((let image, let indexPath)):
                    self?.photos[indexPath.row].image = image.pngData()
                    self?.addBlurEffect(to: image, at: indexPath)
                case .failure(let error):
                    self?.controller?.handleError(error)
                }
            }
        }
    }
    
    public func cancelPrefetchingForRows(at indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            imageService.stopDownloadImage(for: indexPath)
            filterImageService.cancelAddingBlurEffect(at: indexPath)
        }
    }
    
    private func addBlurEffect(to image: UIImage, at indexPath: IndexPath) {
        FilterImageService.shared.addBlurEffect(to: image, at: indexPath) { [weak self] image in
            DispatchQueue.main.async {
                guard let image = image else { return }
                self?.photos[indexPath.row].isBlurred = true
                self?.photos[indexPath.row].image = image.pngData()
                self?.controller?.didAddBlurEffect(to: image, at: indexPath)
            }
        }
    }
}
