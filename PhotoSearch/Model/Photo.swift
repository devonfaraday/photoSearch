//
//  Photo.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let title: String
    var photoSizes: [PhotoSize] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
    }
}

//{"id":"47291234821","owner":"170235545@N05","secret":"26e74a2f08","server":"7862","farm":8,"title":"IMG_0331","ispublic":1,"isfriend":0,"isfamily":0}
