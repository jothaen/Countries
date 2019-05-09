//
//  TabBarController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 09/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flashcardsViewController = UINavigationController(rootViewController: FlashcardsMenuViewController())
        flashcardsViewController.tabBarItem = UITabBarItem(title: "Flashcards", image: nil, tag: 0)
        
        let countriesListViewController = UINavigationController(rootViewController: CountriesListViewController())
        countriesListViewController.tabBarItem = UITabBarItem(title: "Countries list", image: nil, tag: 1)
        
        viewControllers = [countriesListViewController, flashcardsViewController]
    }
    
}
