//
//  RequestDispatcher.swift
//  SampleNetworking
//
//  Created by Max Ward on 26/07/2022.
//

import Foundation

enum APIError: Error, Equatable {
    case emptyData
    case invalidResponse
    case serverError
    case badRequest(String?)
    case parseError(String?)
    case unknown
}

class RequestDispatcher {
    var networkSession: NetworkSessionProtocol!
    
    init(networkSession: NetworkSessionProtocol) {
        self.networkSession = networkSession
    }
    
    /// Ejecuta una request basada en el protocolo Request Protocol y devuelve la respuesta decodificada en un objeto Codable
    /// En caso de error, lanzara un ApiError
    func execute<T: Codable>(urlRequest: RequestProtocol, of type: T.Type) async throws -> T? {
        guard var request = urlRequest.buildRequest() else {
            throw APIError.badRequest("Bad Request")
        }
        request.timeoutInterval = 10
        let (data, response) = try await networkSession.data(request: request)
        let verifyData = verify(data: data, of: T.self, urlResponse: response as! HTTPURLResponse)
        switch verifyData {
        case .success(let value):
            return value
        case .failure(let apiError):
            throw apiError
        }
    }
    
    /// Verificay el codigo de respuesta y en case de ser 200 decodifica el objeto de respuesta segun el parametro generico
    /// y devuelve un objeto Result con el objeto decodificado
    /// En caso de error devuelve el objeto Result con un custom error del tipo ApiError
    private func verify<T: Codable>(data: Any?, of type: T.Type, urlResponse: HTTPURLResponse) -> Result<T?, APIError> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let decodedData = try jsonDecoder.decode(T.self, from: data as! Data)
                    return .success(decodedData)
                } catch {
                    return .failure(APIError.parseError("error decoding data"))
                }
            } else {
                return .failure(APIError.emptyData)
            }
        case 400...499:
            return .failure(APIError.badRequest("no anda"))
        case 500...599:
            return .failure(APIError.serverError)
        default:
            return .failure(APIError.unknown)
        }
    }
}
