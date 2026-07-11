//
//  TinyChores03App.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//

import SwiftUI

enum TinyChoresSceneID {
    static let tasks = "tasks"
}

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
        WindowGroup("Tiny Chores", id: "main") {
            MainView(viewModel: mainViewModel)
                .environmentObject(database)
                .frame(minWidth: 480, minHeight: 360)
        }
        .defaultSize(width: 640, height: 460)
        .commands {
            TinyChoresCommands()
        }

        Window("Tasks", id: TinyChoresSceneID.tasks) {
            TaskManagerView()
                .environmentObject(database)
                .frame(minWidth: 460, minHeight: 340)
        }
        .defaultSize(width: 520, height: 480)
        .windowResizability(.contentMinSize)

        Settings {
            SettingsView()
                .environmentObject(database)
        }
    }
}

private struct TinyChoresCommands: Commands {
    @Environment(\.openWindow) private var openWindow

    var body: some Commands {
        CommandMenu("Tasks") {
            Button("Show Tasks") {
                openWindow(id: TinyChoresSceneID.tasks)
            }
            .keyboardShortcut("t", modifiers: [.command, .option])
        }
    }
}
