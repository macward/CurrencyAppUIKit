//
//  CurrencyDataSource.swift
//  DolarBlue
//
//  Created by Max Ward on 01/03/2023.
//

import Foundation

protocol CurrencyDataSource {
    
    func fetchAll() async throws -> [CurrencyPresentationModel]?
    func store(_ objects: [CurrencyDataObject]?) async throws
}
