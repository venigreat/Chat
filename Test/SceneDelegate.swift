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
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

