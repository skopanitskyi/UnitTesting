//
//  ImageService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation

class ImageService {

    public let shared = ImageService()
    
    private let operations: [Int: Operation] = [:]
    private let operationQueue = OperationQueue()
    
    private init() { }
    
}

class ImageOperation: Operation {
   
    
}
