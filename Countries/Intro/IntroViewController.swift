//
//  IntroViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class IntroViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let pages = [
        IntroPageModel(imageName: "globe", descriptionText: "First page"),
        IntroPageModel(imageName: "globe", descriptionText: "Second page"),
        IntroPageModel(imageName: "globe", descriptionText: "Third page"),
        IntroPageModel(imageName: "globe", descriptionText: "Fourth page")
    ]
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroPageCell
        
        cell.model = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private func initCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.register(IntroPageCell.self, forCellWithReuseIdentifier: "cell")
    }
    
}

