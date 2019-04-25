//
//  MainViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let requestsHandler = RequestsHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .green
        requestsHandler.getAllCountries(successHandler: { countries in
            print("Fetched \(countries.count) countries!!!!")
        }) { (error) in
            print(error)
        }
    }
}
