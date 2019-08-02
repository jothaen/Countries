//
//  DefaultsRepository.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation

class DefaultsRepository {
    
    private let defaults = UserDefaults.standard
    
    public func setIntroductionDisplayed() {
        defaults.set(true, forKey: Constants.DEFAULTS_KEY_INTRODUCTION_SHOWN)
    }
    
    public func wasIntroductionDisplayed() -> Bool {
        return defaults.bool(forKey: Constants.DEFAULTS_KEY_INTRODUCTION_SHOWN)
    }
    
    
}
