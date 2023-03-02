//
//  CurrencyListPresenter.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation

class CurrencyListPresenterDefault: CurrencyListPresenter {
    
    var view: CurrencyListView!
    var interactor: CurrencyListInteractor!
    
    func updateAvailableCurrencies(_ currencies: [CurrencyPresentationModel]) {
        view.updateCurrencyList(currencies)
    }
    
    func getCurrencies() {
        self.interactor.getCurrencies()
    }
    func handleError(message: String) {
        print(message)
    }
}
