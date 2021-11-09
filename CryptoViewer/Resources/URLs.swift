//
//  URLs.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

enum URLs {
    private static let baseUrl = URL(string: "https://api.coinranking.com/v2/")!
    static let getCoins = baseUrl.appendingPathComponent("coins")
    static let getCoin = baseUrl.appendingPathComponent("coin/")
}
