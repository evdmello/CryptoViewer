//
//  SparklineNormalizer.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

struct SparklineNormalizer {
    static func normalize(_ data: [String]) -> [Double] {
        let dataInDouble = data.map { $0.toDouble }
        let maxValue = dataInDouble.max() ?? 0
        let minValue = dataInDouble.min() ?? 0
        let difference = maxValue - minValue
        let normalizedValues = dataInDouble.map { Double(($0 - minValue) / difference) }
        return normalizedValues
    }
}
