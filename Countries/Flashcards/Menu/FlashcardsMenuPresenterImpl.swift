//
//  FlashcardsMenuPresenter.swift
//  Countries
//
//  Created by Piotr Kozłowski on 09/05/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import Foundation

class FlashcardsMenuPresenterImpl : FlashcardsMenuPresenter {
    
    private let requestsHandler = RequestsHandler()
    
    private var countries: [Country] = [] {
        didSet {
            view?.showFlashcardsCount(count: countries.count)
        }
    }
    
    private var order: Order = Order.Alphabetically
    
    var view: FlashcardsMenuView?
    
    func viewReady() {
        view?.showLoader()
        getAllCountries()
    }
    
    func onOrderChanged(order: Order) {
        self.order = order
    }
    
    func onScopeChanged(region: Region) {
        view?.showLoader()
        getCountriesByRegion(region: region)
    }
    
    func onAllCountriesSelected() {
        view?.showLoader()
        getAllCountries()
    }
    
    func onStartButtonClicked() {
        let flashcards = countries.map ({ (country) -> Flashcard in
            return Flashcard(firstPage: country.name, secondPage: country.capital)
        })
        
        let sortedFlashcards = sortFlashcards(flashcards: flashcards, order: order)
        
        view?.openLearnView(flashcards: sortedFlashcards)
    }
    
    private func sortFlashcards(flashcards: [Flashcard], order: Order) -> [Flashcard] {
        switch order {
        case .Alphabetically:
            return flashcards.sorted(by: { (first, second) -> Bool in
                return first.firstPage < second.firstPage
            })
        case .Shuffle:
            return flashcards.shuffled()
        }
    }
    
    private func getAllCountries() {
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.requestsHandler.getAllCountries(successHandler: { countries in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.countries = countries
                    self.view?.hideLoader()
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                    guard let self = self else { return }
                    self.view?.hideLoader()
                }
            }
        }
    }
    
    private func getCountriesByRegion(region: Region) {
        DispatchQueue.global(qos: .background).async{ [weak self] in
            self?.requestsHandler.getCountriesByRegion(region: region, successHandler: { countries in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.countries = countries
                    self.view?.hideLoader()
                }
            }) { (error) in
                DispatchQueue.main.async {
                    print(error)
                    guard let self = self else { return }
                    self.view?.hideLoader()
                }
            }
        }
    }
    
}
