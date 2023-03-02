//
//  CurrenciesUseCase.swift
//  DolarBlue
//
//  Created by Max Ward on 08/08/2022.
//

import Foundation

class CurrencyUseCaseDefault: CurrencyUseCase {
    
    var repository: CurrencyRepository!
    
    init(repository: CurrencyRepository) {
        self.repository = repository
    }
    
    @discardableResult
    func getListOfCurrencies() async throws -> [CurrencyPresentationModel]? {
        do {
            try await repository.fetchAll()
            guard let objects = try await repository.fetchAll() else { throw APIError.unknown }
            return objects.map { CurrencyPresentationModel(currency: $0 )}
        } catch {
            throw APIError.unknown
        }
    }
    
}
