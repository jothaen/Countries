//
//  RequestsHandler.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class RequestsHandler {
    private let BASE_URL = "https://restcountries.eu/rest/v2"
    private let ALL_COUNTRIES_ENDPOINT = "/all"
    private let COUNTRIES_BY_REGION_ENDPOINT = "/region/"
    
    static let genericError = "Something went wrong. Please try again later"
    
    func getAllCountries(successHandler: @escaping ([Country]) -> Void, errorHandler: @escaping ErrorHandler) {
        guard let url = URL(string: BASE_URL + ALL_COUNTRIES_ENDPOINT) else {
            assertionFailure("Failure while constructing url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        get(urlRequest: urlRequest, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func getCountriesByRegion(region: Region, successHandler: @escaping ([Country]) -> Void, errorHandler: @escaping ErrorHandler) {
        guard let url = URL(string: BASE_URL + COUNTRIES_BY_REGION_ENDPOINT + region.rawValue) else {
            assertionFailure("Failure while constructing url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        get(urlRequest: urlRequest, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    private func get<T: Codable>(urlRequest: URLRequest,successHandler: @escaping (T) -> Void, errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error)  in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(RequestsHandler.genericError)
                return
            }
            
            if urlResponse.isSuccessful() {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(RequestsHandler.genericError)
                }
                
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            
            errorHandler(RequestsHandler.genericError)
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler).resume()
    }
}

private extension Optional where Wrapped == URLResponse {
    func isSuccessful() -> Bool {
        guard let urlResponse = self as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
