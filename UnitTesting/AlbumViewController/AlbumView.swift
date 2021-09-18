//
//  AlbumView.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 18.09.2021.
//

import Foundation
import UIKit

final class AlbumView: UIView {
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelfView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSelfView()
    }
    
    private func configureSelfView() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
