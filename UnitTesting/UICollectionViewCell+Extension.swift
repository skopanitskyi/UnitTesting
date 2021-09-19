//
//  UICollectionViewCell+Extension.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 19.09.2021.
//

import UIKit

extension UICollectionViewCell {
    public static var identifier: String {
        return String(reflecting: Self.self)
    }
}
