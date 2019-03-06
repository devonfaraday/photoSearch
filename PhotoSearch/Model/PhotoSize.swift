//
//  Sizes.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

struct SizesDecoder: Decodable {
    let sizes: PhotoSizes
}

struct PhotoSizes: Decodable {
    let size: [PhotoSize]
    
    var thumbnail: PhotoSize? {
            if size.count >= 6 {
                return size[5]
            } else if size.count >= 5 {
                return size[4]
            } else if size.count >= 4 {
                return size[3]
            } else if size.count >= 3 {
                return size[2]
            } else if size.count >= 2 {
                return size[1]
            } else {
                return size.first
            }
    }
    
    // the biggest image is always the last in the array.  Since it's not always called original I only grab the last item
    var original: PhotoSize? {
            return size.last
    }
}

struct PhotoSize: Decodable {
    let label: String
    let source: URL
}
