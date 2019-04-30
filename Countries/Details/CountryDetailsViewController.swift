//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 30/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = country.name
        view.backgroundColor = .white
    }
    
}
