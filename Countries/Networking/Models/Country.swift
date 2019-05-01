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
    
    let latlng: [Double]
    
    let flag: String
    
    let languages: [Language]
    let currencies: [Currency]
}

extension Country {
    
    func getListedInfo() -> Array<(String, String)> {
        var infoArray = Array<(String, String)>()
        infoArray.append(("Country name",  name))
        infoArray.append(("Capital city", capital))
        infoArray.append(("Region",  "\(subregion), \(region)"))
        infoArray.append(("Population", "\(population)"))
        if (area != nil) {
            infoArray.append(("Area", "\(area!) sq. km"))
        }
        
        infoArray.append(("Language",  languages.description))
        infoArray.append(("Time zone", timezones.description))
        
        infoArray.append(("Currency",  currencies.description))
        infoArray.append(("Web domain",  topLevelDomain.description))
        infoArray.append(("Phone prefix",  "+\(callingCodes.description)"))
        return infoArray
    }
    
}

extension Array: CustomStringConvertible where Element: CustomStringConvertible {
    
    var description: String {
        var result = ""
        
        for i in 0...self.count - 1 {
            result.append(self[i].description)
            if (i != self.count - 1) {
                result.append(", ")
            }
        }
        
        return result
    }
}
