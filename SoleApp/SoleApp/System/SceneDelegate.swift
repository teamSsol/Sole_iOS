//
//  SceneDelegate.swift
//  SoleApp
//
//  Created by SUN on 2023/02/06.
//

import UIKit
import KakaoSDKAuth
import SwiftUI
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: AppView(store: Store(initialState: AppFeature.State(),
                                                                                        reducer: { AppFeature()
            ._printChanges() })))
        window?.backgroundColor = .white
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        APIClient.reissueToken()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

