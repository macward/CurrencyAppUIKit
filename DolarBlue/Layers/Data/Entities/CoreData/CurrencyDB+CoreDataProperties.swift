//
//  CurrencyDB+CoreDataProperties.swift
//  DolarBlue
//
//  Created by Max Ward on 11/08/2022.
//
//

import Foundation
import CoreData


extension CurrencyDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyDB> {
        return NSFetchRequest<CurrencyDB>(entityName: "CurrencyDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var sellPrice: Double
    @NSManaged public var buyPrice: Double
    @NSManaged public var averagePrice: Double
    @NSManaged public var previousPrice: Double

}

extension CurrencyDB : Identifiable {

}

extension CurrencyDB {
    func filledWith(_ object: CurrencyDataObject) {
        self.name = object.name
        self.code = object.internal_name
        self.sellPrice = object.sell_price
        self.buyPrice = object.buy_price ?? 0
        self.averagePrice = object.averagePrice()
        self.previousPrice = object.previous_price ?? 0
    }
}
