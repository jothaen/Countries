//
//  Currency.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

struct Currency: Codable, CustomStringConvertible {
    let code: String
    let name: String
    let symbol: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol) ?? ""
    }
    
    var description: String {
         return "\(name) (\(code))"
    }
    
}
