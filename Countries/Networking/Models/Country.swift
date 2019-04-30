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

extension Country {
    
    func getListedInfo() -> Array<String> {
        var infoArray = Array<String>()
        infoArray.append("Country name:  \(name)")
        infoArray.append("Capital city:  \(capital)")
        infoArray.append("Region:  \(subregion), \(region)")
        infoArray.append("Population:  \(population)")
        if (area != nil) {
            infoArray.append("Area:  \(area!) km2")
        }
        
        let mappedLanguages = languages.map { (language) -> String in
            language.name
        }
        
        infoArray.append("Language:  \(mappedLanguages.getPrintableString())")
        infoArray.append("Time zone:  \(timezones.getPrintableString())")
        
        let mappedCurrencies = currencies.map { (currency) -> String in
            currency.getDisplayableValue()
        }
        
        infoArray.append("Currency:  \(mappedCurrencies.getPrintableString())")
        infoArray.append("Web domain:  \(topLevelDomain.getPrintableString())")
        infoArray.append("Phone prefix:  +\(callingCodes.getPrintableString())")
        return infoArray
    }
    
}

extension Array where Element == String {
    
    func getPrintableString() -> String {
        var result = ""
        
        for i in 0...self.count - 1 {
            result.append(self[i])
            if (i != self.count - 1) {
                result.append(", ")
            }
        }
        
        return result
    }
}
