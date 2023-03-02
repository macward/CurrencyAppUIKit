//
//  CurrencySmallCollectionViewCell.swift
//  DolarBlue
//
//  Created by Max Ward on 11/08/2022.
//

import UIKit

class CurrencySmallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(withCurrency currency: CurrencyPresentationModel) {
        self.titleCellLabel.text = currency.name
        self.buyPriceLabel.text = String(format: "$%.0f", currency.buyPrice!)
        self.sellPriceLabel.text = String(format: "$%.0f", currency.sellPrice)
        self.averagePriceLabel.text = String(format: "$%.0f", currency.averagePrice)
        switch currency.variation {
        case .up:
            self.backgroundColor = UIColor(named: "cellUp")
        case .down:
            self.backgroundColor = UIColor(named: "cellDown")
        case .equal:
            self.backgroundColor = UIColor(named: "defaultCellColor")
        }
    }

}
