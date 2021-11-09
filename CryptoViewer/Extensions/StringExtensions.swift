//
//  StringExtensions.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }

    func attributedString() -> NSAttributedString {
        NSAttributedString(string: self)
    }

    var toDouble: Double {
        Double(self) ?? 0
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
