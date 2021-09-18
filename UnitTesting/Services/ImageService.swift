//
//  ImageService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation
import UIKit

final class ImageService {
    
    public static let shared = ImageService()
    
    private var imageLoaders: [IndexPath: ImageLoader] = [:]
    
    private init() { }
    
    public func downloadImage(for stringURL: String,
                              and indexPath: IndexPath,
                              compltion: @escaping (Result<(image: UIImage, indexPath: IndexPath), Error>) -> Void) {
        let imageLoader = ImageLoader(stringURL: stringURL)
        imageLoaders[indexPath] = imageLoader
        
        imageLoader.loadImage { [weak self] result in
            switch result {
            case .success(let image):
                compltion(.success((image, indexPath)))
            case .failure(let error):
                compltion(.failure(error))
            }
            self?.imageLoaders[indexPath] = nil
        }
    }
    
    public func stopDownloadImage(for indexPath: IndexPath) {
        imageLoaders[indexPath]?.stopDownloadImage()
    }
}

struct ImageLoader {
    
    private let stringURL: String
    private let networkService = NetworkService.shared
    
    init(stringURL: String) {
        self.stringURL = stringURL
    }
    
    public func loadImage(compltion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: stringURL) else {
            compltion(.failure(ImageLoaderError.failedCreateURL))
            return
        }
        
        networkService.downloadData(for: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    compltion(.failure(ImageLoaderError.failedCreateImage))
                    return
                }
                compltion(.success(image))
            case .failure(let error):
                compltion(.failure(error))
            }
        }
    }
    
    public func stopDownloadImage() {
        networkService.cancelDownloading()
    }
}

extension ImageLoader {
    enum ImageLoaderError: Error {
        case failedCreateURL
        case failedCreateImage
    }
}
