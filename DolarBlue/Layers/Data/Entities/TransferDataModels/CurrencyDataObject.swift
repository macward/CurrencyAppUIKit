//
//  CurrencyObjectResponse.swift
//  DolarBlue
//
//  Created by Max Ward on 08/08/2022.
//

import Foundation

struct CurrencyDataObject: Codable {
    let name: String
    let internal_name: String
    let sell_price: Price
    let buy_price: Price?
    let previous_price: Price?
    let update_at: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.internal_name = try container.decode(String.self, forKey: .internal_name)
        self.sell_price = try container.decode(Price.self, forKey: .sell_price)
        self.buy_price = try container.decodeIfPresent(Price.self, forKey: .buy_price)
        self.previous_price = try container.decodeIfPresent(Price.self, forKey: .previous_price)
        self.update_at = try container.decode(String.self, forKey: .update_at)
    }
    
    
}

extension CurrencyDataObject {
    func averagePrice() -> Double {
        if let buyPrice = self.buy_price {
            return (buyPrice + self.sell_price) / 2
        } else {
            return sell_price
        }
    }
}
