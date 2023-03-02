//
//  CurrencyRepository.swift
//  DolarBlue
//
//  Created by Max Ward on 07/08/2022.
//

import Foundation

protocol CurrencyRepository {
    
    @discardableResult
    func fetchAll() async throws -> [CurrencyDataObject]?
}
