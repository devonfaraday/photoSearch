//
//  PhotosController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

class PhotosController {
    
    private let apiKey: String = "api_key"
    private let methodValue: String = "flickr.photos.search"
    private let methodKey: String = "method"
    private let textKey: String = "text"
    private let pageKey: String = "page"
    private let perPageKey: String = "perPage"
    
    func fetchPhotos(withText text: String, onPage page: Int, completion: @escaping(Photos?, Error?) -> Void) {
        guard let url: URL = URL(string: Constants.baseUrlString) else { completion(nil, nil); return }
        let parameters: URLParameterDictionary = [methodKey: methodValue, apiKey: Constants.apiKey, textKey: text, pageKey: "\(page)", perPageKey: "25"]
        let networkController = NetworkController()
        networkController.performRequest(withURL: url, urlParameters: parameters) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }
    }
}
