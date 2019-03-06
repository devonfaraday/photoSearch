//
//  Photos.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

// PhotosDecoder is to help with decoing the json easier
struct PhotosDecoder: Decodable {
    let photos: Photos
}

class Photos: Decodable {
    var page: Int = 1
    let perPage: Int = 25
    var photo: [Photo] = []
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case photos
        case page
        case perPage
        case photo
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        photo = try values.decode([Photo].self, forKey: .photo)
    }
}
