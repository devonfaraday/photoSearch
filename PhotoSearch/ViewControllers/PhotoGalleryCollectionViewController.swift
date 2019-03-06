//
//  PhotoGalleryCollectionViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoGalleryCollectionViewController: UICollectionViewController {

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
}
