//
//  CurrencyEndpoints.swift
//  DolarBlue
//
//  Created by Max Ward on 07/08/2022.
//

import Foundation

enum CurrencyEndpoints: RequestProtocol {
    
    case all
    case usdBlue
    case euroBlue
    case usdt
    case dai
    
    var baseUrl: String {
        return "http://localhost:3000"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/currencies"
    }
    
    var headers: RequestHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: RequestParameters? {
        return nil
    }
}
