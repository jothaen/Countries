//
//  Country.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

struct Country: Codable {
    let numericCode: String?
    
    let name: String
    let capital: String
    let alpha2Code: String
    
    let topLevelDomain: [String]
    let callingCodes: [String]
    let timezones: [String]
    
    let region: String
    let subregion: String
    
    let population: Int
    let area: Float?
    
    let latlng: [Float]
    
    let flag: String
    
    let languages: [Language]
    let currencies: [Currency]

}
