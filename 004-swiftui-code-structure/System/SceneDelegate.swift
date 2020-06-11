//
//  SceneDelegate.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let playerStatsView = PlayerStatsView(model: .init(loader: Database()))
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: playerStatsView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }


}

