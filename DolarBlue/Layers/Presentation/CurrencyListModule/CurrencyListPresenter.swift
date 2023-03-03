//
//  CurrencyListPresenter.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation
import Combine

class CurrencyListPresenterDefault: CurrencyListPresenter {
    
    var interactor: CurrencyListInteractor!
    
    private let currencyObjectsSubject = CurrentValueSubject<[CurrencyPresentationModel], Never>([])
    var currencyObjectsPublisher: AnyPublisher<[CurrencyPresentationModel], Never> {
        return currencyObjectsSubject.eraseToAnyPublisher()
    }

    private let viewStateSubject = CurrentValueSubject<ViewState, Never>(.idle)
    var viewStatePublisher: AnyPublisher<ViewState, Never> {
        return viewStateSubject.eraseToAnyPublisher()
    }

    func getCurrencies() {
        self.viewStateSubject.send(.loading)
        self.interactor.getCurrencies()
    }
    
    func operationSuccess(_ objects: [CurrencyPresentationModel]) {
        currencyObjectsSubject.send(objects)
        self.viewStateSubject.send(.loaded)
    }
    
    func operationFailure(_ error: APIError) {
        print(error.localizedDescription)
        self.viewStateSubject.send(.loaded)
    }
}
