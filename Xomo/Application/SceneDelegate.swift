//
//  SceneDelegate.swift
//  Xomo
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let controller: UIViewController!
        
        if UserDefaults.standard.bool(forKey: "BoolOnboardingViewController") == false {
            controller = OnboardingViewController()
            UserDefaults.standard.setValue(true, forKey: "BoolOnboardingViewController")
        } else {
            let tabBarController = TabBarController()
            controller = tabBarController
        }
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
