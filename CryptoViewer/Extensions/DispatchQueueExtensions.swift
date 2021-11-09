//
//  DispatchQueueExtensions.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import Foundation

extension DispatchQueue {
    static func runOnMainIfNeeded(_ execute: @escaping () -> Void) {
        if Thread.isMainThread {
            execute()
        } else {
            main.async(execute: execute)
        }
    }
}
