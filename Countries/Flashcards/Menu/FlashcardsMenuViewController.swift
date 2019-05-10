//
//  FlashcardsMenuViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 09/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit
import Lottie

class FlashcardsMenuViewController: UIViewController {
    
    private let presenter = FlashcardsMenuPresenterImpl()
    
    private let scopeItems = ["All"] + Region.allCases.map({ (region) -> String in
        region.rawValue
    })
    
    private let orderItems = Order.allCases.map { (order) -> String in
        order.rawValue
    }
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Learn capital cities of all the countries in a easy way!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flashcardsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Flashcards count: "
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scopeSegmentedControl = UISegmentedControl(items: scopeItems)
    
    private lazy var scopeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let label = UILabel()
        label.text = "Select scope:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        let segmentedControl = scopeSegmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(scopeSegmentedControlIndexChanged), for: .valueChanged)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(segmentedControl)
        return stackView
    }()
    
    private lazy var orderSegmentedControl = UISegmentedControl(items: orderItems)
    
    private lazy var orderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let label = UILabel()
        label.text = "Select order:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        let segmentedControl = orderSegmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(orderSegmentedControlIndexChanged), for: .valueChanged)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(segmentedControl)
        return stackView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let's go!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(onStartButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var loaderView: AnimationView = {
        let lotView = AnimationView(name: "loader")
        lotView.translatesAutoresizingMaskIntoConstraints = false
        lotView.loopMode = .loop
        lotView.play()
        lotView.isHidden = true
        return lotView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Flashcards"
        initViews()
        
        presenter.view = self
        presenter.viewReady()
    }
    
    private func initViews() {
        view.addSubview(loaderView)
        view.addSubview(infoLabel)
        view.addSubview(scopeStackView)
        view.addSubview(orderStackView)
        view.addSubview(flashcardsCountLabel)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([            
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 50),
            loaderView.widthAnchor.constraint(equalToConstant: 50),
            
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scopeStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40),
            scopeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scopeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            orderStackView.topAnchor.constraint(equalTo: scopeStackView.bottomAnchor, constant: 20),
            orderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            flashcardsCountLabel.topAnchor.constraint(equalTo: orderStackView.bottomAnchor, constant: 20),
            flashcardsCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flashcardsCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: flashcardsCountLabel.bottomAnchor, constant: 40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func scopeSegmentedControlIndexChanged() {
        let selectedIndex = scopeSegmentedControl.selectedSegmentIndex
        
        switch selectedIndex {
        case 0:
            presenter.onAllCountriesSelected()
        default:
            guard let region = Region(rawValue: scopeItems[selectedIndex]) else { return }
            presenter.onScopeChanged(region: region)
        }
    }
    
    @objc func orderSegmentedControlIndexChanged() {
        let selectedIndex = orderSegmentedControl.selectedSegmentIndex
        
        guard let order = Order(rawValue: orderItems[selectedIndex]) else { return }
        presenter.onOrderChanged(order: order)
    }
    
    @objc func onStartButtonClicked() {
        presenter.onStartButtonClicked()
    }
}

extension FlashcardsMenuViewController : FlashcardsMenuView {
    
    func openLearnView(flashcards: [Flashcard]) {
        flashcards.forEach { (flashcard) in
            print(flashcard.firstPage)
        }
    }
    
    func showLoader() {
        loaderView.isHidden = false
    }
    
    func hideLoader() {
        loaderView.isHidden = true
    }
    
    func showFlashcardsCount(count: Int) {
        flashcardsCountLabel.text = "Flashcards count: \(count)"
    }
}
