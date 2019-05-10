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
    
    private var collectionView: UICollectionView?
    private var flowLayout: UICollectionViewFlowLayout
    
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
    }

    private func initCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        
        guard let collectionView = collectionView else {
            assertionFailure("This should never happen ; )")
            return
        }
        
        collectionView.register(FlashcardCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
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
