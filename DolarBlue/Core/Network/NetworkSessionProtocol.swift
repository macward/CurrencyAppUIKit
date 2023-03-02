//
//  NetworkSession.swift
//  SampleNetworking
//
//  Created by Max Ward on 26/07/2022.
//

import Foundation

protocol NetworkSessionProtocol {
    func data(request: URLRequest) async throws -> (Data, URLResponse)
}

class NetworkSession: NSObject, NetworkSessionProtocol {
    
    private var session: URLSession!
    
    public override convenience init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 30
        sessionConfiguration.waitsForConnectivity = true
        self.init(configuration: sessionConfiguration)
    }
    
    public init(configuration: URLSessionConfiguration) {
        super.init()
        self.session = URLSession(configuration: configuration)
    }
    
    func data(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: request)
    }
}
