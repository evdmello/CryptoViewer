//
//  NetworkService.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

public protocol NetworkService {
    func performRequest<ExpectedData: Decodable>(_ request: URLRequest, expectedData: ExpectedData.Type, completion: @escaping (Result<ExpectedData, NetworkError>) -> Void)
}
