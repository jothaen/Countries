//
//  CountryCell.swift
//  Countries
//
//  Created by Piotr Kozłowski on 25/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit
import WebKit

class CountryCell: UITableViewCell {
    
    var country: Country? {
        didSet {
            guard let country = country else { return }
            nameLabel.text = country.name
        }
    }
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            flagImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor)
        ])
    }
}
