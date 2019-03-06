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
}

struct PhotoSize: Decodable {
    let label: String
    let source: URL
}
