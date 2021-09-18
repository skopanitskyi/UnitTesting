//
//  AlbumService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import Foundation

private enum Routes: String {
    case albums
    
    var url: String {
        switch self {
        case .albums:
            return "\(Constants.baseUrl)/\(rawValue)"
        }
    }
}

final class AlbumService {
    
    public static let shared = AlbumService()
    
    private init() { }
    
    public func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        guard let url = URL(string: Routes.albums.url) else {
            completion(.failure(ImageLoader.ImageLoaderError.failedCreateURL))
            return
        }
        
        NetworkService.shared.downloadData(for: url) { result in
            switch result {
            case .success(let data):
                let albums = try? JSONDecoder().decode([Album].self, from: data)
                completion(.success(albums ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
