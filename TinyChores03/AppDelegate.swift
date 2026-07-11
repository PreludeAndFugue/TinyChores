//
//  AppDelegate.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
#endif

#if os(macOS)
@main
struct TinyChores03App: App {
    @StateObject private var database: ChoresDatabase
    @StateObject private var mainViewModel: MainViewModel

    init() {
        let database = ChoresDatabase(userDefaults: .standard)
        _database = StateObject(wrappedValue: database)
        _mainViewModel = StateObject(wrappedValue: MainViewModel(db: database))
    }

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainViewModel)
                .environmentObject(database)
                .frame(minWidth: 480, minHeight: 360)
        }
    }
}
#endif
