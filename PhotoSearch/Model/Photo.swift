//
//  Photo.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

class Photo: Decodable {
    let id: String
    let title: String
    var photoSizes: PhotoSizes? = nil
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
    }
}
