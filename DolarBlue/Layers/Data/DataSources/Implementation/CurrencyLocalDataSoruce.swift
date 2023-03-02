//
//  CurrencyLocalDataSoruce.swift
//  DolarBlue
//
//  Created by Max Ward on 01/03/2023.
//

import Foundation

class CurrencyLocalDataSoruce: CurrencyDataSource {
    
    func fetchAll() async throws -> [CurrencyPresentationModel]? {
        guard let result = try await CoreDataStack.shared.fetch(CurrencyDB.fetchRequest()) else { throw APIError.noData}
        return result.map { object in
            CurrencyPresentationModel(dbo: object)
        }
    }
    
    func store(_ objects: [CurrencyDataObject]?) async throws {
        guard let objects = objects else {
            throw APIError.noData
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
            throw APIError.serverError("")
        }
    }
}
