//
//  CurrencyPresentationItem.swift
//  DolarBlue
//
//  Created by Max Ward on 11/08/2022.
//

import Foundation

enum PriceVariation {
    case up, down, equal
}

struct CurrencyPresentationModel {
    
    let name: String
    let sellPrice: Price
    let buyPrice: Price?
    let previousPrice: Price?
    
    var variation: PriceVariation {
        if let lastPrice = previousPrice {
            switch previousPrice {
            case _ where sellPrice < lastPrice:
                return .down
            case _ where sellPrice > lastPrice:
                return .up
            default: return .equal
            }
        } else { return .equal }
    }
    
    var averagePrice: Price {
        if let _buyPrice = buyPrice {
            return (_buyPrice + sellPrice) / 2
        } else { return sellPrice }
    }
    
    init(currency: CurrencyDataObject) {
        self.name = currency.name
        self.sellPrice = currency.sell_price
        self.buyPrice = currency.buy_price
        self.previousPrice = currency.previous_price
    }
    
    init(dbo: CurrencyDB) {
        self.name = dbo.name ?? ""
        self.sellPrice = dbo.sellPrice
        self.buyPrice = dbo.buyPrice
        self.previousPrice = dbo.previousPrice
    }
}
