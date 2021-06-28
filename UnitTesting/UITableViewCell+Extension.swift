//
//  UITableViewCell+Extension.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(reflecting: Self.self)
    }
}
