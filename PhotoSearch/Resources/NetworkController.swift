//
//  NetworkController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

struct NetworkController {
    
    // This app is only using 1 base url so I placed it inside the request to minimize code repetitiveness
    func performRequest(withUrlParameters parameters: URLParameterDictionary?,
                        completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: Constants.baseUrlString) else { completion(nil, nil); return }
        let requestURL = getURL(byAddingParameters: parameters, toURL: url)
        let request = URLRequest(url: requestURL)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
    
    // return a new url with the parameters included
    private func getURL(byAddingParameters parameters: URLParameterDictionary?, toURL url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
}
