//
//  CurrencyListProtocols.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation

protocol CurrencyListView: AnyObject{
    func updateCurrencyList(_ currencies: [CurrencyPresentationModel])
}

protocol CurrencyListInteractor: AnyObject {
    func getCurrencies()
}

protocol CurrencyListPresenter: AnyObject {
    func getCurrencies()
    func operationSuccess(_ objects: [CurrencyPresentationModel])
    func operationFailure(_ error: APIError)
}
