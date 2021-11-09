//
//  NetworkError.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

public enum NetworkError: Error {
    case connectivity
    case invalidResponseCode
    case invalidData
}
