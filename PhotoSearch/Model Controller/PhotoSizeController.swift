//
//  PhotoSizeController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

class PhotoSizeController {
    
    private let getSizesKey: String = "flickr.photos.getSizes"
    private let photoIdKey: String = "photo_id"
    
    // fetch the sizes for an image with it's id
    func fetchImageSizes(withID photoId: String, completion: @escaping([PhotoSize], Error?) -> Void) {
        let parameters: URLParameterDictionary = [Constants.methodKey: getSizesKey, Constants.apiKey: Constants.apiKeyValue, photoIdKey: photoId]
        let networkController = NetworkController()
        networkController.performRequest(withUrlParameters: parameters) { (data, error) in
            if let data = data {
                if let sizesDecoder: SizesDecoder = try? JSONDecoder().decode(SizesDecoder.self, from: data) {
                    let sizes: PhotoSizes = sizesDecoder.sizes
                    completion(sizes.size, nil)
                } else {
                    completion([], nil)
                }
            } else {
                completion([], error)
            }
            
        }
    }
}
