//
//  SceneDelegate.swift
//  Test
//
//  Created by a.belyaev3 on 18.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var previousState: UIApplication.State = .background

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) { }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        logChangeState(method: #function)
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        logChangeState(method: #function)
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        logChangeState(method: #function)
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        logChangeState(method: #function)
    }
    
    private func logChangeState(method: String) {
        Logger.changeState(from: previousState.stringValue,
                           to: UIApplication.shared.applicationState.stringValue, method: method)
        previousState = UIApplication.shared.applicationState
    }
}
