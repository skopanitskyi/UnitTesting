//
//  AlbumCell.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import UIKit

final class AlbumCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelfCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSelfCell()
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    private func configureSelfCell() {
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
}

