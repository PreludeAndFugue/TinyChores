//
//  MainView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

struct MainView: View {
    @EnvironmentObject var db: ChoresDatabase
    @StateObject var viewModel: MainViewModel
    
    
    var body: some View {
        screenContent
        .sheet(isPresented: $viewModel.showingSettings) {
            SettingsView()
        }
    }


    private var screenContent: some View {
        content
            .background(screenBackground)
    }


    private var content: some View {
        ZStack {
            MainTextView(name: viewModel.currentChore.name, toggle: $viewModel.textViewToggle)
        }
        .overlay(settingsButton, alignment: .topLeading)
        .overlay(nextButton, alignment: .bottomTrailing)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    private var settingsButton: some View {
        SettingsButtonView(action: viewModel.toggleShowingSettings)
            .padding(.top, 12)
            .padding(.leading, 16)
    }


    private var nextButton: some View {
        NextButtonView(action: completeChore)
            .padding(.trailing, 20)
            .padding(.bottom, 20)
    }


    @ViewBuilder
    private var screenBackground: some View {
        #if os(iOS)
        Color(UIColor.systemBackground)
            .ignoresSafeArea()
        #else
        Color.clear
        #endif
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
