//
//  Currency.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

struct Currency: Codable, CustomStringConvertible {
    let code: String?
    let name: String?
    let symbol: String?
    
    var description: String {
         return code ?? "-"
    }
    
}
