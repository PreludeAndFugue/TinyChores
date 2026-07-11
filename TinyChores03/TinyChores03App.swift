//
//  TinyChores03App.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//

import SwiftUI

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
            mainContent
        }
    }


    @ViewBuilder
    private var mainContent: some View {
        MainView(viewModel: mainViewModel)
            .environmentObject(database)

        #if os(macOS)
            .frame(minWidth: 480, minHeight: 360)
        #endif
    }
}
