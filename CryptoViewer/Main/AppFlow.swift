//
//  AppFlow.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import UIKit

final class AppFlow {
    private let navigator: UINavigationController

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let service = HTTPClient(session: .shared)
        let viewModel = MarketViewModel(service: service, coinSelected: showCoinDetail)
        let viewController: MarketViewController = .instantiate()
        viewController.initialize(with: viewModel)
        navigator.setViewControllers([viewController], animated: false)
    }

    private func showCoinDetail(coin: Coin) {
        let vc: CoinDetailViewController = .instantiate()
        let service = HTTPClient(session: .shared)
        let viewModel = CoinDetailViewModel(service: service, coin: coin)
        vc.initialize(with: viewModel)
        navigator.pushViewController(vc, animated: true)
    }
}
