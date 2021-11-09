//
//  UITableViewExtensions.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import UIKit

extension UITableView {
    func showErrorMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 50, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        DispatchQueue.runOnMainIfNeeded {
            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }
    }
}
