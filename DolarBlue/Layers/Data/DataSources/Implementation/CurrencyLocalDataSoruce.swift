//
//  CurrencyLocalDataSoruce.swift
//  DolarBlue
//
//  Created by Max Ward on 01/03/2023.
//

import Foundation

class CurrencyLocalDataSoruce: CurrencyDataSource {
    
    func fetchAll() async throws -> [CurrencyDataObject]? {
        guard let data = try await LoadLocalData.fromJson(withName: "currencies", of: [CurrencyDataObject].self) else {
            throw APIError.emptyData
        }
        return data
    }
    
    func store(_ objects: [CurrencyDataObject]?) async throws {
        guard let objects = objects else {
            throw APIError.emptyData
        }
        
        do {
            try await CoreDataStack.shared.clear("CurrencyDB")
        } catch {
            throw APIError.unknown
        }
        
        do {
            objects.forEach { item in
                CurrencyDB(context: CoreDataStack.shared.context).filledWith(item)
            }
            try await CoreDataStack.shared.saveContext()
        } catch {
            throw APIError.serverError
        }
    }
}
