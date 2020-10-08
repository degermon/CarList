//
//  ImageCache.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-08.
//

import AlamofireImage

class ImageCache {
    
    static let shared = ImageCache()
    let imageCache = AutoPurgingImageCache()

    func checkCacheForImageWith(key: String, completion: @escaping (Image?)->()) {
        let image = imageCache.image(withIdentifier: key)
        
        if image == nil {
            Networking.shared.getImageFor(url: key) { (newImage) in
                guard let newImage = newImage else { return }
                self.imageCache.add(newImage, withIdentifier: key)
                completion(newImage)
            }
        } else {
            completion(image)
        }
    }
}
