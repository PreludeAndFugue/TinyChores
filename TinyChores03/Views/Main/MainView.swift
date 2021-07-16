//
//  MainView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var db: ChoresDatabase
    @StateObject var viewModel: MainViewModel
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            SettingsButtonView(action: viewModel.toggleShowingSettings)

            ZStack(alignment: .bottomTrailing) {
                MainTextView(name: viewModel.currentChore.name, toggle: $viewModel.textViewToggle)

                NextButtonView(action: completeChore)
            }
        }
        .sheet(isPresented: $viewModel.showingSettings) {
            SettingsView()
        }
    }
}


// MARK: - Private

private extension MainView {
    func completeChore() {
        withAnimation {
            viewModel.finishChore()
        }
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
