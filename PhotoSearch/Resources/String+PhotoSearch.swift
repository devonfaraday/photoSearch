//
//  String+PhotoSearch.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/6/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

extension String {
    
    // these are keys that are used in more then 1 place
    /* Parameter Keys */
    static var apiKey: String { get { return "api_key" } }
    static var formatKey: String { get { return "format" } }
    static var formatValue: String { get { return "json" } }
    static var methodKey: String { get { return "method" } }
    static var noJsonCallbackKey: String { get { return "nojsoncallback" } }
    static var noJsonCallbackValue: String { get { return "1" } }
    
    /* Segue Identifiers */
    static var toEmbededCollectionViewSegueIdentifier: String { get { return "toEmbededCollectionView" } }
    static var toEmbededSearchBarSegueIdentifier: String { get { return "toEmbededSearchBar" } }
    static var toPhotoDetailSegueIdentifier: String { get { return "toPhotoDetail" } }
}
