//
//  FlashcardCell.swift
//  Countries
//
//  Created by Piotr Kozłowski on 10/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class FlashcardCell : UICollectionViewCell {
    
    private var firstPageShown = true
    
    var model: Flashcard? {
        didSet {
            guard let model = model else { return }
            textLabel.text = model.firstPage
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var flashcardContainer: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        
        view.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFlashcardContainer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFlashcardContainer() {
        addSubview(flashcardContainer)
        
        NSLayoutConstraint.activate([
            flashcardContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            flashcardContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            flashcardContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashcardContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        flashcardContainer.addTarget(self, action: #selector(flashcardClicked), for: .touchUpInside)
    }
    
    @objc func flashcardClicked() {
        if firstPageShown {
            firstPageShown = false
            textLabel.text = model?.secondPage
            
            animateFlip(type: UIView.AnimationOptions.transitionFlipFromLeft)
            
        } else {
            firstPageShown = true
            textLabel.text = model?.firstPage
            animateFlip(type: UIView.AnimationOptions.transitionFlipFromRight)
        }
    }
    
    private func animateFlip(type: UIView.AnimationOptions) {
        UIView.transition(with: flashcardContainer, duration: 0.3, options: type, animations: nil, completion: nil)
    }
    
}
