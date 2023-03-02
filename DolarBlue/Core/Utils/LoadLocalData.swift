//
//  LoadJsonFromFile.swift
//  DolarBlue
//
//  Created by Max Ward on 09/08/2022.
//

import Foundation

final class LoadLocalData {
    
    /// Devuelve un objeto o una lista de objetos cargados desde un archivo JSON
    ///
    /// 	- Parameter name: Nombre del archivo que deseamos abrir
    ///     - Parameter type: el tipo de objeto al que deseamos convertir los datos
    ///     - Returns: Una lista de objetos que conforman la tipo especificado
    ///
    static func fromJson<T: Codable>(withName name: String, of type: T.Type) async throws -> T? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw APIError.noData
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
