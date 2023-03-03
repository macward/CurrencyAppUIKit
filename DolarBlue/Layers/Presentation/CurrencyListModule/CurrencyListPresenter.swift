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
    
    func getCurrencies() {
        self.interactor.getCurrencies()
    }
    
    func operationSuccess(_ objects: [CurrencyPresentationModel]) {
        view.updateCurrencyList(objects)
    }
    
    func operationFailure(_ error: APIError) {
        print(error.localizedDescription)
    }
}
