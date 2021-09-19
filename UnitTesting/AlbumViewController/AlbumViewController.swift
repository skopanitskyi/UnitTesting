//
//  AlbumViewController.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import UIKit

protocol AlbumViewControllerInput: AnyObject {
    func updateCollectionView()
    func didLoadImage(_ image: UIImage, at indexPath: IndexPath)
    func didAddBlurEffect(to image: UIImage, at indexPath: IndexPath)
    func handleError(_ error: Error)
}

final class AlbumViewController: UIViewController {
    
    public var presenter: AlbumViewPresenterInput?
    
    private let selfView = AlbumView()
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelfView()
        presenter?.loadPhotos()
    }
    
    private func configureSelfView() {
        title = presenter?.getAlbumTitle()
        selfView.collectionView.delegate = self
        selfView.collectionView.dataSource = self
        selfView.collectionView.prefetchDataSource = self
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension AlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.identifier,
            for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        if let data = presenter?.getPhoto(at: indexPath.row).image, let image = UIImage(data: data) {
            cell.setImage(image)
        } else {
            presenter?.loadPhoto(for: indexPath)
        }
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension AlbumViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        presenter?.prefetchRows(at: indexPaths)
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        presenter?.cancelPrefetchingForRows(at: indexPaths)
    }
}

extension AlbumViewController: AlbumViewControllerInput {
    
    func updateCollectionView() {
        selfView.collectionView.reloadData()
    }
    
    func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error",
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
    }
    
    func didLoadImage(_ image: UIImage, at indexPath: IndexPath) {
        let cell = selfView.collectionView.cellForItem(at: indexPath) as? PhotoCell
        cell?.setImage(image)
    }
    
    func didAddBlurEffect(to image: UIImage, at indexPath: IndexPath) {
        let cell = selfView.collectionView.cellForItem(at: indexPath) as? PhotoCell
        cell?.setImage(image)
    }
}
