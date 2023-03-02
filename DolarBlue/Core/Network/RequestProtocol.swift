//
//  RequestManager.swift
//  SampleNetworking
//
//  Created by Max Ward on 25/07/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol RequestProtocol {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: RequestHeaders? { get }
    var parameters: RequestParameters? { get }
}

extension RequestProtocol {
    
    public func buildRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            return nil
        }
        urlComponents.path = self.path
        urlComponents.queryItems = self.queryItems()
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = self.requestBody()
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
    
    private func queryItems() -> [URLQueryItem]? {
        guard method == .get, let parameters = self.parameters else {
            return nil
        }
        return parameters.map {(key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    private func requestBody() -> Data? {
        guard [.post, .put, .patch].contains(method), let parameters = self.parameters else {
            return nil
        }
        var jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            return nil
        }
        return jsonBody
    }
}
