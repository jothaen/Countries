//
//  FlashcardsLearningViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 10/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class FlashcardsLearningViewController: UIViewController {
    
    var flashcards: [Flashcard] = []
    
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    }()
    
    private var flowLayout: UICollectionViewFlowLayout
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(flashcards: [Flashcard]) {
        self.flashcards = flashcards
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Learn"
        
        initCollectionView()
        initCounterLabel()
    }

    private func initCollectionView() {
        collectionView.register(FlashcardCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
    }

    private func initCounterLabel() {
        view.addSubview(counterLabel)
        
        NSLayoutConstraint.activate([
            counterLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        counterLabel.text = "1/\(flashcards.count)"
    }
}

extension FlashcardsLearningViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FlashcardsLearningViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? FlashcardCell {
            cell.model = flashcards[indexPath.row]
        }
        
        return cell
    }

}

extension FlashcardsLearningViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / view.frame.width) + 1
        counterLabel.text = "\(currentPage)/\(flashcards.count)"
    }
}
