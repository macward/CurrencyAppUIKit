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
            presenter?.updateAvailableCurrencies(response)
        } catch APIError.noData {
            presenter?.handleError(message: "Error obteniendo datos")
        } catch {
            presenter?.handleError(message: "generic error")
        }
        
    }
}
