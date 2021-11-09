//
//  SceneDelegate.swift
//  CryptoViewer
//
//  Created by pcadmin on 03/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let flow = AppFlow(navigator: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        flow.start()
    }
}

