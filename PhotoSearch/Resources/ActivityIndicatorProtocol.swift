//
//  ActivityIndicatorProtocol.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/6/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import UIKit

protocol ActivityIndicatorable {
    
    var activityIndicator: UIActivityIndicatorView! { get set }
}

extension ActivityIndicatorable {
    // unhides indicator and starts animating
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    // hides indicator and stops animating
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
