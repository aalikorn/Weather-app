//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let homeRouter = HomeRouter.start()
        let initialVC = homeRouter.entry
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()
    }


}

