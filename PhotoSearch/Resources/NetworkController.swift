//
//  NetworkController.swift
//  PhotoSearch
//
//  Created by Christian McMullin on 3/5/19.
//  Copyright © 2019 Christian McMullin. All rights reserved.
//

import Foundation

struct NetworkController {
    
    func performRequest(withURL url: URL,
                        urlParameters: URLParameterDictionary?,
                        completion: @escaping(Data?, Error?) -> Void) {
        let requestURL = getURL(byAddingParameters: urlParameters, toURL: url)
        let request = URLRequest(url: requestURL)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
    }
    
    private func getURL(byAddingParameters parameters: URLParameterDictionary?, toURL url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        guard let url = components?.url else { fatalError("URL is nil") }
        return url
    }
}
