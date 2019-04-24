//
//  IntroViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 24/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class IntroViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let pages = [
        IntroPageModel(imageName: "globe", descriptionText: "First page"),
        IntroPageModel(imageName: "globe", descriptionText: "Second page"),
        IntroPageModel(imageName: "globe", descriptionText: "Third page"),
        IntroPageModel(imageName: "globe", descriptionText: "Fourth page")
    ]
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = self.currentPage
            handleNextButtonText(index: self.currentPage)
        }
    }
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREVIOUS", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
         button.addTarget(self, action: #selector(onPreviousClicked), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = pages.count
        control.currentPageIndicatorTintColor = .red
        control.pageIndicatorTintColor = .gray
        return control
    }()
    
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
        initBottomButtons()
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
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        currentPage = Int(x / view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private func initCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.register(IntroPageCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func initBottomButtons() {
        let stackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func onNextClicked() {
        currentPage = min(currentPage + 1, pages.count - 1)
        scrollToIndex(index: currentPage)
    }
    
    @objc private func onPreviousClicked() {
        currentPage = max(currentPage - 1, 0)
        scrollToIndex(index: currentPage)
    }
    
    private func scrollToIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func handleNextButtonText(index: Int) {
        var buttonText: String
        if (index == pages.count - 1) {
            buttonText = "CLOSE"
        } else {
            buttonText = "NEXT"
        }
        
        nextButton.setTitle(buttonText, for: .normal)
    }
    
}

