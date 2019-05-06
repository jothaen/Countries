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
    
    var sortingOptions = SortingOptions()
    
    private let segmentedControlItems = ["All"] + Region.allCases.map({ (region) -> String in
        region.rawValue
    })

    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CountryCell.self, forCellReuseIdentifier: "countryCell")
        view.rowHeight = 50
        view.allowsSelection = true
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
        initSortButton()
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
        tableView.delegate = self
        
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
    
    private func initSortButton() {
        let sortByButton = UIBarButtonItem(image: UIImage(named: "icon_sort_by"), style: .plain, target: self, action: #selector(onSortByButtonClicked))
        let sortOrderButton = UIBarButtonItem(image: UIImage(named: "icon_sort_order"), style: .plain, target: self, action: #selector(onSortOrderButtonClicked))
        navigationItem.rightBarButtonItems = [sortOrderButton, sortByButton]
    }
    
    @objc func onSortOrderButtonClicked() {
        let actionSheet = UIAlertController(title: nil, message: "Sorting order", preferredStyle: .actionSheet)
        let ascendingAction = UIAlertAction(title: "Ascending", style: .default) { (UIAlertAction) in
            self.sortOrderChanged(newSortOrder: SortOrder.ascending)
        }
        let descendingAction = UIAlertAction(title: "Descending", style: .default) { (UIAlertAction) in
            self.sortOrderChanged(newSortOrder: SortOrder.descending)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(ascendingAction)
        actionSheet.addAction(descendingAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func onSortByButtonClicked() {
        let actionSheet = UIAlertController(title: nil, message: "Sorting by", preferredStyle: .actionSheet)
        let nameAction = UIAlertAction(title: "Name", style: .default) { (UIAlertAction) in
            self.sortByChanged(newSortBy: SortBy.name)
        }
        
        let populationAction = UIAlertAction(title: "Population", style: .default) { (UIAlertAction) in
            self.sortByChanged(newSortBy: SortBy.population)
        }
        
        let areaAction = UIAlertAction(title: "Area", style: .default) { (UIAlertAction) in
            self.sortByChanged(newSortBy: SortBy.area)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(nameAction)
        actionSheet.addAction(areaAction)
        actionSheet.addAction(populationAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func fetchAllCountries() {
        loaderView.isHidden = false
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.requestsHandler.getAllCountries(successHandler: { countries in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.countries = self.getSortedCountries(countriesList: countries)
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
                    guard let self = self else { return }
                    self.countries = self.getSortedCountries(countriesList: countries)
                    
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    private func getSortedCountries(countriesList: [Country]) -> [Country] {
        return countriesList.sorted() { left, right in
            
            switch sortingOptions.sortBy {
            case SortBy.name:
                if sortingOptions.sortOrder == SortOrder.ascending {
                    return left.name < right.name
                } else {
                    return left.name > right.name
                }
            
            case SortBy.population:
                if sortingOptions.sortOrder == SortOrder.ascending {
                    return left.population < right.population
                } else {
                    return left.population > right.population
                }
            
            case SortBy.area:
                guard let leftArea = left.area, let rightArea = right.area else { return false }
                if sortingOptions.sortOrder == SortOrder.ascending {
                    return leftArea < rightArea
                } else {
                    return leftArea > rightArea
                }
            }
        }
    }
    
    private func sortByChanged(newSortBy: SortBy) {
        sortingOptions.sortBy = newSortBy
        countries = getSortedCountries(countriesList: countries)
    }
    
    private func sortOrderChanged(newSortOrder: SortOrder) {
        sortingOptions.sortOrder = newSortOrder
        countries = getSortedCountries(countriesList: countries)
    }
}


// MARK: - UITableViewDataSource

extension CountriesListViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        
        if let cell = cell as? CountryCell {
            cell.country = country
            cell.accessoryType = .disclosureIndicator
            imageLoader.loadFlagByCode(code: country.alpha2Code, imageView: cell.flagImageView)
        }
    
        return cell
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableViewDelegate

extension CountriesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row]
        let vc = CountryDetailsViewController(country: selectedCountry)
        navigationController?.pushViewController(vc, animated: true)
    }
}



