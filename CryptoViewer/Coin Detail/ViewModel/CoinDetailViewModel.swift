//
//  CoinDetailViewModel.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

final class CoinDetailViewModel {
    let imageName: String
    let symbol: String
    let name: String
    var isVariationPositive: Observable<Bool>
    var variation: Observable<String>
    var price: Observable<String>
    var normalizedSparkline: Observable<[Double]>
    var tableSections: Observable<[CoinDetailSectionViewModel]>
    var loadError = Observable<String?>(nil)
    private let uuid: String
    private let service: NetworkService

    init(service: NetworkService, coin: Coin) {
        self.service = service
        self.uuid = coin.uuid
        self.imageName = CoinIcons.getImageName(for: coin.symbol)
        self.symbol = coin.symbol
        self.name = coin.name
        self.isVariationPositive = Observable(coin.change.toDouble > 0.0)
        self.variation = Observable(coin.change.toDouble.asPercentString())
        self.price = Observable(coin.price.toDouble.asCurrency())
        self.normalizedSparkline = Observable(SparklineNormalizer.normalize(coin.sparkline))
        self.tableSections = Observable([])
    }

    func load() {
        let request = URLRequestGenerator.getCoin(uuid: uuid)
        service.performRequest(request, expectedData: CoinDetailResponse.self) { [weak self] result in
            switch result {
            case let .success(data):
                let coin = data.data.coin

                let sections: [CoinDetailSectionViewModel] = [
                    CoinDetailSectionViewModel(title: "About \(coin.name)",
                                               items: [
                                                AboutCoinCellViewModel(title: "Ranking".attributedString(),
                                                                       subtitle: coin.rank.string),
                                                AboutCoinCellViewModel(title: "Price in BTC".attributedString(),
                                                                       subtitle: coin.btcPrice),
                                                AboutCoinCellViewModel(title: "24 Hour Volume".attributedString(),
                                                                       subtitle: coin.the24HVolume.toDouble.asCurrency()),
                                                AboutCoinCellViewModel(title: "Market Cap".attributedString(),
                                                                       subtitle: coin.marketCap.toDouble.asCurrency()),
                                                AboutCoinCellViewModel(title: "All Time High".attributedString(),
                                                                       subtitle: coin.allTimeHigh.price.toDouble.asCurrency()),
                                                AboutCoinCellViewModel(title: "Circulating Supply".attributedString(),
                                                                       subtitle: coin.supply.circulating)
                                               ]),
                    CoinDetailSectionViewModel(title: "Description",
                                               items: [
                                                AboutCoinCellViewModel(title: coin.coinDescription.htmlAttributedString(),
                                                                       subtitle: "")
                                               ])
                ]

                self?.tableSections.value = sections
                self?.normalizedSparkline.value = SparklineNormalizer.normalize(coin.sparkline)

            case .failure:
                self?.tableSections.value = []
                self?.loadError.value = "Error while loading \(self?.name ?? "") details"
            }
        }
    }
}
