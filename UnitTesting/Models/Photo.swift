//
//  Photo.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 19.09.2021.
//

import UIKit

struct Photo: Codable {
    public let albumId: Int
    public let id: Int
    public let title: String
    public let url: String
    public let thumbnailUrl: String
    public var image: Data?
    public var isBlurred: Bool? = false
}
