//
//  Observable.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import Foundation

public final class Observable<T> {
    public var value: T {
        didSet { listener?(value) }
    }

    private var listener: ((T) -> Void)?

    public init(_ value: T) {
        self.value = value
    }

    public func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
