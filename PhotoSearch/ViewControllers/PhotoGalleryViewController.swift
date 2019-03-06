//
//  PhotoGalleryViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, ActivityIndicatorable {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: SearchResultsDelegate?
    var photos: Photos?
    var imageTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        photos = Photos()
    }
    
    // MARK: - Photo Fetch Helpers
    func fetchPhotoInfo(withTerms term: String, completion: @escaping(Error?) -> Void) {
        startActivityIndicator()
        if let photos = self.photos {
        let photosController = PhotosController()
            photosController.fetchPhotos(withText: term, onPage: photos.page) { (photos, error) in
                self.photos = photos
                self.stopActivityIndicator()
                completion(error)
            }
        }
    }
    
    // MARK: - Navigation
    //Embed the search bar view controller
    func embedSearchBarVC(with segue: UIStoryboardSegue) {
        guard let searchVC = segue.destination as? SearchViewController else { return }
        searchVC.delegate = self
    }
    
    // embed the photo gallery collection view
    func embedPhotoGalleryCollectionVC(with segue: UIStoryboardSegue) {
        guard let photoGalleryCollectionViewController = segue.destination as? PhotoGalleryCollectionViewController else { return }
        photoGalleryCollectionViewController.delegate = self
        delegate = photoGalleryCollectionViewController
    }
    
    // segue to the full size photo
    func segueToPhotoDetailVC(with segue: UIStoryboardSegue, sender: Any?) {
        guard let toPhotoDetailVC = segue.destination as? PhotoViewController else { return }
        toPhotoDetailVC.imageTitle = self.imageTitle
        toPhotoDetailVC.photoSize = sender as? PhotoSize
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .toEmbededCollectionViewSegueIdentifier?:
            embedPhotoGalleryCollectionVC(with: segue)
        case .toEmbededSearchBarSegueIdentifier?:
            embedSearchBarVC(with: segue)
        case .toPhotoDetailSegueIdentifier?:
            segueToPhotoDetailVC(with: segue, sender: sender)
        default:
            print("No Segue Used")
        }
    }
}

// MARK: - SearchVCDelegate method
extension PhotoGalleryViewController: SearchVCDelegate {
    func searchTermWasUpdated(with term: String) {
        self.fetchPhotoInfo(withTerms: term) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.delegate?.searchResulsUpdated(with: self.photos, and: term)
            }
        }
    }
}

// MARK: - CollectionViewSelectionDelegate
extension PhotoGalleryViewController: CollectionViewCellSelectionDelegate {
    func didSelectCollectionViewCell(_ photoSize: PhotoSize?, withTitle title: String) {
        self.imageTitle = title
        performSegue(withIdentifier: .toPhotoDetailSegueIdentifier, sender: photoSize)
    }
}

protocol SearchResultsDelegate: class {
    func searchResulsUpdated(with results: Photos?, and term: String)
}
