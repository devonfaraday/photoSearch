//
//  PhotosController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

class PhotosController {
    
    // Keys for the parameters needed for fetching photo id and title
    private let methodValue: String = "flickr.photos.search"
    private let textKey: String = "text"
    private let pageKey: String = "page"
    private let perPageKey: String = "perPage"
    
    // Fetch photo id and title
    func fetchPhotos(withText text: String, onPage page: Int, completion: @escaping(Photos?, Error?) -> Void) {
        let parameters: URLParameterDictionary = [Constants.methodKey: methodValue, Constants.apiKey: Constants.apiKeyValue, textKey: text, pageKey: "\(page)", perPageKey: "25", "format": "json", "nojsoncallback": "1"]
        let networkController = NetworkController()
        networkController.performRequest(withUrlParameters: parameters) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                if let photosDecoder: PhotosDecoder = try? JSONDecoder().decode(PhotosDecoder.self, from: data) {
                    let photos = photosDecoder.photos
                    completion(photos, nil)
                }
            }
        }
    }
}
