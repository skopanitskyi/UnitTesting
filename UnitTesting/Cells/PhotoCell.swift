//
//  PhotoCell.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 19.09.2021.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelfCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSelfCell()
    }
    
    public func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    private func configureSelfCell() {
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
