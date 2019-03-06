//
//  Photos.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

class Photos: Decodable {
    var page: Int = 1
    let perPage: Int = 25
    var photos: [Photo] = []
}
