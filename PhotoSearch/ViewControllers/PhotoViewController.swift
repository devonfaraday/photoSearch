//
//  PhotoViewController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let photosController = PhotosController()
        photosController.fetchPhotos(withText: "Soccer", onPage: 2) { (photos, error) in
            
        }
    }
}
