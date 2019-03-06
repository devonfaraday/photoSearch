//
//  PhotoGalleryCollectionViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotoGalleryCollectionViewController: UICollectionViewController {
    
    var photos: [Photos] = []

    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    // Register cell nib
    func registerCell() {
        let nib: UINib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
    
        
    
        return cell
    }
}
