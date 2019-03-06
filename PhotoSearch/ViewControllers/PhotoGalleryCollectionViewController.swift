//
//  PhotoGalleryCollectionViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotoGalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CollectionViewCellSelectionDelegate?
    var isPaginating: Bool = false
    var newObjectCount: Int = 0
    var photos: Photos? {
        didSet {
            if !isViewLoaded {
                loadViewIfNeeded()
            }
                reloadDataOnMainQueue()
        }
    }
    var term: String = ""

    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    // MARK: - Fetch More Pages
    func fetchPhotoInfo(completion: @escaping(Error?) -> Void) {
        isPaginating = true
        self.photos?.page += 1
        if let photos = self.photos {
            let photosController = PhotosController()
            photosController.fetchPhotos(withText: self.term, onPage: photos.page) { (photos, error) in
                guard let newPhotos = photos?.photo else { completion(nil); return }
                self.newObjectCount = newPhotos.count
                self.photos?.photo.append(contentsOf: newPhotos)
                self.updateViewForPagination()
                completion(error)
            }
        }
    }
    
    func updateViewForPagination() {
        var indexPaths: [IndexPath] = []
        var itemCount = 0
        DispatchQueue.main.async {
            itemCount = self.collectionView.numberOfItems(inSection: 0)
        }
        for _ in 1...newObjectCount {
            indexPaths.append(IndexPath(item: itemCount, section: 0))
            itemCount += 1
        }
        DispatchQueue.main.async {
            self.collectionView.insertItems(at: indexPaths)
            self.collectionView.reloadItems(at: indexPaths)
        }
        isPaginating = false
    }
    
    func reloadDataOnMainQueue() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func paginateIfNeeded(_ indexPath: IndexPath) {
        guard let photos = self.photos else { return }
        if indexPath.item > photos.photo.count - 15 && !isPaginating {
            fetchPhotoInfo { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
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
        guard let photos = self.photos else { return 0 }
        return photos.photo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        paginateIfNeeded(indexPath)
        let photo = photos?.photo[indexPath.item]
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = photos?.photo[indexPath.item] else { return }
        let photoSize = photo.photoSizes?.original
        delegate?.didSelectCollectionViewCell(photoSize, withTitle: photo.title)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAndHeight = collectionView.bounds.width / 1 - 2
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension PhotoGalleryCollectionViewController: SearchResultsDelegate {
    func searchResulsUpdated(with results: Photos?, and term: String) {
        self.term = term
        self.photos = results
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
}

protocol CollectionViewCellSelectionDelegate: class {
    func didSelectCollectionViewCell(_ photoSize: PhotoSize?, withTitle title: String)
}
