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
    
    private lazy var dispatcher = RequestDispatcher(networkSession: NetworkSession())
    
    init(remoteDataSource: CurrencyDataSource, localDataSource: CurrencyDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchAll() async throws -> [CurrencyDataObject]? {
        // Crea una solicitud de API para recuperar todas las divisas
        let request = CurrencyEndpoints.all

        // Ejecuta la solicitud usando el dispatcher de solicitudes
        guard let result = try await dispatcher.execute(urlRequest: request, of: [CurrencyDataObject].self) else {
            throw APIError.noData
        }

        // almacena los datos en la base de datos local
        try await self.localDataSource.store(result)

        return result
    }
}
