//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 30/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit
import Foundation

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
        view.heightAnchor.constraint(equalToConstant: 256).isActive = true
        view.backgroundColor = .lightGray
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
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(flagImageView)
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func displayCountryInfo() {
        imageLoader.loadFlagByCode(code: country.alpha2Code, imageView: flagImageView)
        
        for (key, value) in country.getListedInfo() {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.attributedText = getFormattedString(label: key, value: value)
            label.numberOfLines = 10
            stackView.addArrangedSubview(label)
        }
    }
    
    private func getFormattedString(label: String, value: String) -> NSAttributedString {
        let string = NSMutableAttributedString()
        
        string.append(NSAttributedString(
            string: "\(label): ",
            attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
            )
        )
        
        string.append(NSAttributedString(
            string: value,
            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
            )
        )
        
        return string
        
    }
    
}
