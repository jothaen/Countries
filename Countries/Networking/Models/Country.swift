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
    let area: Float
    
    let latlng: [Double]
    
    let languages: [Language]
    let currencies: [Currency]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numericCode = try values.decodeIfPresent(String.self, forKey: .numericCode)
        name = try values.decode(String.self, forKey: .name)
        capital = try values.decode(String.self, forKey: .capital)
        alpha2Code = try values.decode(String.self, forKey: .alpha2Code)
        topLevelDomain = try values.decode([String].self, forKey: .topLevelDomain)
        callingCodes = try values.decode([String].self, forKey: .callingCodes)
        timezones = try values.decode([String].self, forKey: .timezones)
        region = try values.decode(String.self, forKey: .region)
        subregion = try values.decode(String.self, forKey: .subregion)
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decodeIfPresent(Float.self, forKey: .area) ?? 0
        latlng = try values.decode([Double].self, forKey: .latlng)
        languages = try values.decode([Language].self, forKey: .languages)
        currencies = try values.decode([Currency].self, forKey: .currencies)
    }
}

extension Country {
    
    func getListedInfo() -> Array<(String, String)> {
        var infoArray = Array<(String, String)>()
        infoArray.append(("Country name",  name))
        infoArray.append(("Capital city", capital))
        infoArray.append(("Region",  "\(subregion), \(region)"))
        infoArray.append(("Population", "\(population)"))
        if (area != 0) {
            infoArray.append(("Area", "\(area) sq. km"))
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
