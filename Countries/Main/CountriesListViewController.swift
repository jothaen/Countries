//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    private let requestsHandler = RequestsHandler()
    private let imageLoader = ImageLoader()
    
    private let tableView = UITableView()
    
    private var countries: [Country] = [] {
        didSet {
            tableView.reloadData()
            title = "All countries (\(countries.count))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        fetchCountries()
    }
    
    private func initTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryCell.self, forCellReuseIdentifier: "countryCell")
        tableView.rowHeight = 50
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchCountries() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.requestsHandler.getAllCountries(successHandler: { countries in
                DispatchQueue.main.async {
                    self?.countries = countries
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension CountriesListViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryCell
        let country = countries[indexPath.row]
        
        cell.country = country
        imageLoader.loadFlagByCode(code: country.alpha2Code, imageView: cell.flagImageView)
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
