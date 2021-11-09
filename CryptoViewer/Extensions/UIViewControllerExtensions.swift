//
//  UIViewControllerExtensions.swift
//  CryptoViewer
//
//  Created by Errol on 05/11/21.
//

import UIKit

extension UIViewController {
    static func instantiate<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T else { return T() }
        return viewController
    }

    func showAlert(message: String) {
        DispatchQueue.runOnMainIfNeeded {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alert = UIAlertController(title: "Error Occurred", message: message, preferredStyle: .alert)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}
