//
//  MarketViewModel.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import Foundation

final class MarketViewModel {
    var coins = Observable<[MarketCoinTableViewCellViewModel]>([])
    var total24hVolume = Observable<String>("")
    var totalMarketCap = Observable<String>("")
    var loadError: Observable<String?> = Observable(nil)
    private let service: NetworkService
    private let select: (Coin) -> Void

    init(service: NetworkService, coinSelected: @escaping (Coin) -> Void) {
        self.service = service
        self.select = coinSelected
    }

    func load() {
        let request = URLRequestGenerator.getCoins()
        service.performRequest(request, expectedData: MarketResponse.self) { [weak self] result in
            switch result {
            case let .success(data):
                self?.coins.value = data.data.coins.map({ coin in
                    MarketCoinTableViewCellViewModel(coin: coin) {
                        self?.select(coin)
                    }
                })
                self?.total24hVolume.value = "24h Volume: $" + data.data.stats.total24HVolume
                self?.totalMarketCap.value = "Total Market Cap: $" + data.data.stats.totalMarketCap
            case .failure:
                self?.loadError.value = "Error retrieving Cryptocurrency data.\nPlease check your internet connectivity and try again."
                self?.coins.value = []
                self?.total24hVolume.value = ""
                self?.totalMarketCap.value = ""
            }
        }
    }
}




