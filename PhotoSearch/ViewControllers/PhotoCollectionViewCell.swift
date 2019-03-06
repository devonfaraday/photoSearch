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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photo = nil
        self.titleLabel.text = nil
        self.photoImageView.image = nil
    }
    
    // Fetch the image from either the cached image or download from the source
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
    
    // Get the imageSizes
    func fetchPhotoSizesIfNeeded(completion: @escaping() -> Void) {
        if self.photo?.photoSizes == nil {
            guard let id = self.photo?.id else { completion(); return }
            let photoSizeController = PhotoSizeController()
            DispatchQueue.global().async {
                photoSizeController.fetchImageSizes(withID: id) { (sizes, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    self.photo?.photoSizes = sizes
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    
    // update the image view
    func updateImageView(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.photoImageView.image = image
        }
    }
    
    // update the title label
    func updateTitle() {
        guard let title = photo?.title else { return }
        titleLabel.text = title
    }
    
    // update all the ui
    func updateUI() {
        fetchPhotoSizesIfNeeded {
            self.fetchImage()
        }
        updateTitle()
    }
}
