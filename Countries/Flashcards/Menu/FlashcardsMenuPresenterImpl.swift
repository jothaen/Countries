//
//  FlashcardsMenuPresenter.swift
//  Countries
//
//  Created by Piotr Kozłowski on 09/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation

class FlashcardsMenuPresenterImpl : FlashcardsMenuPresenter {
    
    private var countries: [Country] = []
    
    private var order: Order = Order.Alphabetically
    
    var view: FlashcardsMenuView?
    
    func viewReady() {
        view?.showLoader()
    }
    
    func onOrderChanged(order: Order) {
        self.order = order
    }
    
    func onScopeChanged(region: Region) {
        view?.showLoader()
        // TODO fetch data
        view?.hideLoader()
    }
    
    func onStartButtonClicked() {
        // TODO
        //view?.openLearnView(flashcards: <#T##[Flashcard]#>)
    }
    
}
