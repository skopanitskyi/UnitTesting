//
//  PhotoService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 19.09.2021.
//

import Foundation

private enum Routes: String {
    case photos
    
    func getUrl(for albumId: Int) -> String {
        switch self {
        case .photos:
            return "\(Constants.baseUrl)/albums/\(albumId)/\(rawValue)"
        }
    }
}

final class PhotoService {
    
    public static let shared = PhotoService()
    
    private init() { }
    
    public func getPhotos(album id: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: Routes.photos.getUrl(for: id)) else {
            completion(.failure(ImageLoader.ImageLoaderError.failedCreateURL))
            return
        }
        NetworkService.shared.downloadData(for: url) { result in
            switch result {
            case .success(let data):
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
