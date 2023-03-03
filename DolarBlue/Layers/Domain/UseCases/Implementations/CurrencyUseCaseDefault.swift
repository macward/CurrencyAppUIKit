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
        } catch APIError.emptyData {
            print("APIError.emptyData")
            throw APIError.unknown
        } catch APIError.invalidResponse {
            print("APIError.invalidResponse")
            throw APIError.unknown
        } catch APIError.unknown {
            print("APIError.unknown")
            throw APIError.unknown
        } catch APIError.badRequest(let message) {
            print("APIError.badRequest: \(String(describing: message))")
            throw APIError.unknown
        } catch APIError.serverError {
            print("APIError.serverError")
            throw APIError.unknown
        } catch APIError.parseError(let message) {
            print("APIError.parseError: \(String(describing: message))")
            throw APIError.unknown
        } catch {
            throw APIError.unknown
        }
    }
    
}
