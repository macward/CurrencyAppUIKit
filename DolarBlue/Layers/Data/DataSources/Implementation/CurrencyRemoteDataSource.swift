//
//  CurrencyRemoteDataSource.swift
//  DolarBlue
//
//  Created by Max Ward on 01/03/2023.
//

import Foundation

class CurrencyRemoteDataSource: CurrencyDataSource {
    
    func fetchAll() async throws -> [CurrencyPresentationModel]? {
        
        guard let data = try await LoadLocalData.fromJson(withName: "currencies", of: [CurrencyDataObject].self) else {
            throw APIError.noData
        }
        var converted: [CurrencyPresentationModel] = []
        for item in data {
            converted.append(CurrencyPresentationModel(currency: item))
        }
        return converted
    }
    
    func store(_ objects: [CurrencyDataObject]?) async throws {
        fatalError()
    }
}
