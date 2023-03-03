//
//  CurrencyListInteractor.swift
//  DolarBlue
//
//  Created by Max Ward on 08/08/2022.
//

import Foundation

class CurrencyListInteractorDefault: CurrencyListInteractor {
    
    var useCase: CurrencyUseCase!
    var presenter: CurrencyListPresenter?
    
    init(useCase: CurrencyUseCase) {
        self.useCase = useCase
    }
    
    func getCurrencies() {
        Task {
            await self.makeRequest()
        }
    }
    
    private func makeRequest() async {
        do {
            guard let response = try await self.useCase.getListOfCurrencies() else { return }
            self.presenter?.operationSuccess(response)
        } catch (let error) {
            self.presenter?.operationFailure(error as! APIError)
        }
        
    }
}
