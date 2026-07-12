//
//  MainView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
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
            MainTextView(
                name: viewModel.currentChore.name,
                choreID: viewModel.currentChore.id
            )
        }
        .overlay(nextButton, alignment: .bottomTrailing)
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
