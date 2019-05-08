//
//  SortingOptions.swift
//  Countries
//
//  Created by Piotr Kozłowski on 06/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

struct SortingOptions {
    var sortBy: SortBy = SortBy.name
    var sortOrder: SortOrder = SortOrder.ascending
}

enum SortBy {
    case name
    case area
    case population
}

enum SortOrder {
    case ascending
    case descending
}

