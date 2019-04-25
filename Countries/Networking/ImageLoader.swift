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
        load(fromUrl: url, toImageView: imageView)
    }
    
    func load(fromUrl: String, toImageView: UIImageView) {
        let urlRequest = URLRequest(url: URL(string: fromUrl)!)
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                toImageView.image = UIImage(data: data)
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler).resume()
        }
    
    }
}

