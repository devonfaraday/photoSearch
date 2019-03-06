//
//  PhotoViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, ActivityIndicatorable {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var imageTitle: String = ""
    var photoSize: PhotoSize? {
        didSet {
            if !isViewLoaded {
                loadViewIfNeeded()
            }
            updateImageView()
            updateTitle()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            activityIndicator.isHidden = true
            updateButtonLayers()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.enableAllOrientation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.enableAllOrientation = false
    }

    // add some layers to the button to make it not so ugly
    func updateButtonLayers() {
        DispatchQueue.main.async {
            self.backButton.layer.cornerRadius = 3
            self.backButton.layer.borderWidth = 2
            self.backButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    // start activity indicator and fetch the big image and then stop the indicator
    func updateImageView() {
        startActivityIndicator()
        guard let url = self.photoSize?.source else { return }
        let imageHandler = ImageHandler()
        imageHandler.downloadImage(url: url) { (image, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.stopActivityIndicator()
            }
        }
    }
    
    func updateTitle() {
        self.titleLabel.text = self.imageTitle
    }
    
    // dimiss view
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
