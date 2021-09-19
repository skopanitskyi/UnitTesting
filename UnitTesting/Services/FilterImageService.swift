//
//  FilterImageService.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 19.09.2021.
//

import UIKit

final class FilterImageService {
    
    private let context = CIContext()
    
    private var operations: [IndexPath: Operation] = [:]
    
    private let operationQueue = OperationQueue()
    
    public static let shared = FilterImageService()
    
    private init() { }
    
    public func addBlurEffect(to image: UIImage, at indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        let operation = Operation()
        operations[indexPath] = operation
        
        operation.completionBlock = { [weak self] in
            guard !operation.isCancelled, let ciImage = CIImage(image: image) else {
                completion(nil)
                return
            }
            let blurFilter = CIFilter(name: "CIGaussianBlur")
            blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
            
            guard !operation.isCancelled,
                  let image = blurFilter?.outputImage?.composited(over: ciImage),
                  let bluredImage = self?.context.createCGImage(image, from: image.extent) else {
                      completion(nil)
                      return
                  }
            completion(UIImage(cgImage: bluredImage))
        }
        operationQueue.addOperation(operation)
    }
    
    public func cancelAddingBlurEffect(at indexPath: IndexPath) {
        operations[indexPath]?.cancel()
    }
}
