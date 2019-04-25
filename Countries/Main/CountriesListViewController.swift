//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class CountriesListViewController: UITableViewController {
    
    private let requestsHandler = RequestsHandler()
    private let imageLoader = ImageLoader()
    
    private var countries: [Country] = [] {
        didSet {
            tableView.reloadData()
            title = "All countries (\(countries.count))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        tableView.register(CountryCell.self, forCellReuseIdentifier: "countryCell")

        fetchCountries()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryCell
        let country = countries[indexPath.row]
        
        cell.country = country
        imageLoader.loadFlagByCode(code: country.alpha2Code, imageView: cell.flagImageView)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    private func fetchCountries() {
        DispatchQueue.global(qos: .background).async {
            self.requestsHandler.getAllCountries(successHandler: { countries in
                DispatchQueue.main.async {
                    self.countries = countries
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
