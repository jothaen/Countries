//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 30/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    private let imageLoader = ImageLoader()
    
    private let country: Country
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 0
        view.distribution = .fill
        return view
    }()
    
    private let flagImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: 128).isActive = true
        return view
    }()
    
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
        initViews()
        
        displayCountryInfo()
    }
    
    private func initViews() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        
    }
    
    private func displayCountryInfo() {
        stackView.addArrangedSubview(flagImageView)
        imageLoader.loadFlagByCode(code: country.alpha2Code, imageView: flagImageView)
        
        for info in country.getListedInfo() {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = info
            label.font = UIFont.systemFont(ofSize: 18)
            label.numberOfLines = 10
            stackView.addArrangedSubview(label)
        }
    }
    
}
