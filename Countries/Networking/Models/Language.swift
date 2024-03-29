//
//  Language.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

struct Language: Codable, CustomStringConvertible {
    let name: String
    
    var description: String {
        return name
    }
}
