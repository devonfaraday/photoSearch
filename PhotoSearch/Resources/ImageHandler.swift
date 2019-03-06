//
//  ImageHandler.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class ImageHandler {
    
    //Image cache keys are their url.absoluteString
    private var imageCache: NSCache = NSCache<NSString, UIImage>()
    
    // Used for downloading and cacheing the thumbnails which are small in memory size
    func downloadImageAndCacheIfNeeded(url: URL, completion: @escaping (UIImage?, Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            downloadData(url: url) { data, error in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, nil)
                }
            }
        }
    }
    
    // used for when a user wants to view the full res image.
    func downloadImage(url: URL, completion: @escaping(UIImage?, Error?) -> Void) {
        downloadData(url: url) { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    // Downlaod the image data
    fileprivate func downloadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().async {
            URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
                completion(data, response, error)
                }.resume()
        }
    }
}
