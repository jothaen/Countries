//
//  FlashcardsMenuContract.swift
//  Countries
//
//  Created by Piotr Kozłowski on 09/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation

protocol FlashcardsMenuView {
    func showLoader()
    func hideLoader()
    func openLearnView(flashcards: [Flashcard])
}
    
protocol FlashcardsMenuPresenter {
    var view: FlashcardsMenuView? { get set }
    
    func viewReady()
    func onStartButtonClicked()
    func onOrderChanged(order: Order)
    func onScopeChanged(region: Region)
}
    

