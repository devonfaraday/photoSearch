//
//  PhotoCollectionViewCell.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/6/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            updateUI()
        }
    }
    
    func fetchImage() {
        guard let imageUrl = photo?.photoSizes?.thumbnail?.source else { return }
        let imageHandler = ImageHandler()
        DispatchQueue.global().async {
            imageHandler.downloadImageAndCacheIfNeeded(url: imageUrl) { (image, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.updateImageView(image)
            }
        }
    }
    
    func updateImageView(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.photoImageView.image = image
        }
    }
    
    func updateTitle() {
        guard let title = photo?.title else { return }
        titleLabel.text = title
    }
    
    func updateUI() {
        fetchImage()
        updateTitle()
    }
}
