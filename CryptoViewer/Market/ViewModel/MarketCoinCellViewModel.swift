//
//  MarketCoinCellViewModel.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

struct MarketCoinTableViewCellViewModel {
    let name: String
    let imageName: String
    let price: String
    let symbol: String
    let variation: String
    let isVariationPositive: Bool
    let select: () -> Void

    init(coin: Coin, selection: @escaping () -> Void) {
        self.name = coin.name
        self.imageName = CoinIcons.getImageName(for: coin.symbol)
        self.price = coin.price.toDouble.asCurrency()
        self.symbol = coin.symbol
        self.variation = coin.change.toDouble.asPercentString()
        self.isVariationPositive = coin.change.toDouble > 0.0
        self.select = selection
    }
}
