//
//  ImageLoader.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    private let COUNTRIES_FLAGS_API_URL = "https://www.countryflags.io/"
    
    func loadFlagByCode(code: String, imageView: UIImageView) {
        let url = COUNTRIES_FLAGS_API_URL + code + "/flat/64.png"
        load(from: url, to: imageView)
    }
    
    func load(from url: String, to imageView: UIImageView) {
        guard let resourceUrl = URL(string: url) else { return }
        let urlRequest = URLRequest(url: resourceUrl)
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler).resume()
        }
    
    }
}

