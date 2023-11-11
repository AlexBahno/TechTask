//
//  ImageLoader.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import SwiftUI
import UIKit
import Combine

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published private(set) var image: UIImage?
    @Published var isLoading = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    var imageCache = _imageCache
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imagefromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imagefromCache
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &cancellableSet)
        
        if let image = image {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.imageCache.setObject(image, forKey: urlString as AnyObject)
            }
        }
    }
}
