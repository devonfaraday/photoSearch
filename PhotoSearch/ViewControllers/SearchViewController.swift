//
//  SearchViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/6/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    weak var delegate: SearchVCDelegate?

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let term = searchBar.text else { return }
        delegate?.searchTermWasUpdated(with: term)
    }
}

protocol SearchVCDelegate: class {
    func searchTermWasUpdated(with term: String)
}
