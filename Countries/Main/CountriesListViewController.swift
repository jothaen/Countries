//
//  CountriesListViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit
import Lottie

class CountriesListViewController: UIViewController {
    
    private let requestsHandler = RequestsHandler()
    private let imageLoader = ImageLoader()
    
    private let segmentedControlItems = ["All"] + Region.allCases.map({ (region) -> String in
        region.rawValue
    })

    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CountryCell.self, forCellReuseIdentifier: "countryCell")
        view.rowHeight = 50
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: segmentedControlItems)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        return view
    }()
    
    private lazy var loaderView: AnimationView = {
        let lotView = AnimationView(name: "loader")
        lotView.translatesAutoresizingMaskIntoConstraints = false
        lotView.loopMode = .loop
        lotView.play()
        lotView.isHidden = true
        return lotView
    }()
    
    private var countries: [Country] = [] {
        didSet {
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            
            title = "Countries count: \(countries.count)"
            loaderView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        
        initSegmentedControl()
        initTableView()
        initLoaderView()
        
        fetchAllCountries()
    }
    
    @objc func segmentedControlIndexChanged() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            fetchAllCountries()
        default:
            guard let region = Region(rawValue: segmentedControlItems[selectedIndex]) else { return }
            fetchCountriesByRegion(region: region)
        }
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func initLoaderView() {
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 50),
            loaderView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func initSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlIndexChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchAllCountries() {
        loaderView.isHidden = false
        DispatchQueue.global(qos: .background).async{ [weak self] in
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
    
    private func fetchCountriesByRegion(region: Region) {
        loaderView.isHidden = false
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.requestsHandler.getCountriesByRegion(region: region, successHandler: { countries in
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
        cell.accessoryType = .disclosureIndicator
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

