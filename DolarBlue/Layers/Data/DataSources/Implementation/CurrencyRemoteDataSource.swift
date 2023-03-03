//
//  CurrencyRemoteDataSource.swift
//  DolarBlue
//
//  Created by Max Ward on 01/03/2023.
//

import Foundation

class CurrencyRemoteDataSource: CurrencyDataSource {
    
    private lazy var dispatcher = RequestDispatcher(networkSession: NetworkSession())
    
    func fetchAll() async throws -> [CurrencyDataObject]? {
        
        // Crea una solicitud de API para recuperar todas las divisas
        let request = CurrencyEndpoints.all

        // Ejecuta la solicitud usando el dispatcher de solicitudes
        guard let result = try await dispatcher.execute(urlRequest: request, of: [CurrencyDataObject].self) else {
            throw APIError.emptyData
        }
        
        return result
        
    }
    
    func store(_ objects: [CurrencyDataObject]?) async throws {
        fatalError()
    }
}
