//
//  NetworkService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation

protocol DataDownloader {
    func downloadData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    func cancelDownloading()
}

final class NetworkService {
    
    public static let shared: DataDownloader = NetworkService()
    
    private var dataTask: URLSessionDataTask?
    
    private init() { }
}

extension NetworkService: DataDownloader {
    
    public func downloadData(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let cachedResponse = getCachedResponse(for: url) {
            completion(.success(cachedResponse.data))
        } else {
            download(for: url, completion: completion)
        }
    }
    
    public func cancelDownloading() {
        dataTask?.cancel()
    }
    
    private func getCachedResponse(for url: URL) -> CachedURLResponse? {
        let request = URLRequest(url: url)
        return URLCache.shared.cachedResponse(for: request)
    }
    
    private func download(for url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error ?? NetworkService.NetworkError.downloadError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkService.NetworkError.dataIsEmpty))
                return
            }
            
            guard let response = response else {
                completion(.failure(NetworkService.NetworkError.responseIsEmpty))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                completion(.failure(NetworkService.NetworkError.serverError))
                return
            }
            
            self.cache(downloaded: data, for: response, and: request)
            completion(.success(data))
        }
        dataTask?.resume()
    }
    
    private func cache(downloaded data: Data, for response: URLResponse, and request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
}

extension NetworkService {
    enum NetworkError: Error {
        case dataIsEmpty
        case responseIsEmpty
        case downloadError
        case serverError
    }
}
