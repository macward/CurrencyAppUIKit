//
//  CurrencyListProtocols.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation
import Combine

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
}

protocol CurrencyListView: AnyObject{
    func updateCurrencyList(_ currencies: [CurrencyPresentationModel])
}

protocol CurrencyListInteractor: AnyObject {
    func getCurrencies()
}

protocol CurrencyListPresenter: AnyObject {
    var currencyObjectsPublisher: AnyPublisher<[CurrencyPresentationModel], Never> { get }
    var viewStatePublisher: AnyPublisher<ViewState, Never> { get }
    func getCurrencies()
    func operationSuccess(_ objects: [CurrencyPresentationModel])
    func operationFailure(_ error: APIError)
}
