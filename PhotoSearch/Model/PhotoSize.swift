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
        return size[2]
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
