//
//  CurrencyRepositoryDefault.swift
//  DolarBlue
//
//  Created by Max Ward on 08/08/2022.
//

import Foundation
import CoreData

class CurrencyRepositoryDefault: CurrencyRepository {
    
    private let remoteDataSource: CurrencyDataSource
    private let localDataSource: CurrencyDataSource
    
    init(remoteDataSource: CurrencyDataSource, localDataSource: CurrencyDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchAll() async throws -> [CurrencyDataObject]? {
        do {
            let objects = try await self.remoteDataSource.fetchAll()
            
            try await self.localDataSource.store(objects)
            
            return objects
        } catch (let error) {
            throw error
        }
        
       
        
    }
}
