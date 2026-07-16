//
//  MainView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.openWindow) private var openWindow
    
    
    var body: some View {
        screenContent
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button(action: showTasks) {
                        Label("Tasks", systemImage: "checklist")
                    }
                    .help("Manage Tasks")

                    SettingsLink {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .help("Open Settings")
                }
            }
    }


    private var screenContent: some View {
        content
            .background(screenBackground)
    }


    private var content: some View {
        ZStack {
            if let chore = viewModel.currentChore {
                MainTextView(
                    name: chore.name,
                    choreID: chore.id
                )
            } else {
                emptyState
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if viewModel.currentChore != nil {
                nextButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    private var nextButton: some View {
        NextButtonView(action: completeChore)
            .padding(.trailing, 20)
            .padding(.bottom, 20)
    }


    private var screenBackground: some View {
        Color.clear
    }


    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.system(size: 36))
                .foregroundStyle(.secondary)

            Text("No Tasks")
                .font(.title3.weight(.semibold))

            Text("Create a task to get started.")
                .foregroundStyle(.secondary)

            Button("Manage Tasks", action: showTasks)
                .buttonStyle(.glassProminent)
                .tint(.purple)
        }
    }
}


// MARK: - Private

private extension MainView {
    func showTasks() {
        openWindow(id: TinyChoresSceneID.tasks)
    }


    func completeChore() {
        viewModel.finishChore()
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let vm = MainViewModel(db: ChoresDatabase(userDefaults: .standard))
    static var previews: some View {
        MainView(viewModel: vm)
    }
}
#endif
