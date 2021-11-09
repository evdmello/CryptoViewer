//
//  URLRequestGenerator.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

struct URLRequestGenerator {
    static func getCoins() -> URLRequest {
        var urlRequest = URLRequest(url: URLs.getCoins)
//        urlRequest.addValue(Keys.apiKey, forHTTPHeaderField: "x-access-token")
        return urlRequest
    }

    static func getCoin(uuid: String) -> URLRequest {
        let url = URLs.getCoin.appendingPathComponent(uuid)
        var urlRequest = URLRequest(url: url)
//        urlRequest.addValue(Keys.apiKey, forHTTPHeaderField: "x-access-token")
        return urlRequest
    }
}
