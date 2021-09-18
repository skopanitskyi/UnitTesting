//
//  AlbumViewController.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import UIKit

protocol AlbumViewControllerInput: AnyObject {
    
}

final class AlbumViewController: UIViewController {
    
    public var presenter: AlbumViewPresenterInput?
    
    private let selfView = AlbumView()
    
    override func loadView() {
        view = selfView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension AlbumViewController: AlbumViewControllerInput {
    
}
