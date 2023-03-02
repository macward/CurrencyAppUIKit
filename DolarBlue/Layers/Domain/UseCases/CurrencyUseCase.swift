//
//  CurrencyUseCase.swift
//  DolarBlue
//
//  Created by Max Ward on 08/08/2022.
//

import Foundation

protocol CurrencyUseCase {
    func getListOfCurrencies() async throws -> [CurrencyPresentationModel]?
}
