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
    @State var showingSettings = false
    @StateObject var viewModel: MainViewModel


    @State var textViewToggle = false

    @State var opacity = 1.0
    @State var scale: CGFloat = 1
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            SettingsButtonView(action: showSettings)

            ZStack(alignment: .bottomTrailing) {
                MainTextView(name: viewModel.currentChore.name, toggle: $textViewToggle)

                NextButtonView(action: completeChore)
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }


    func showSettings() {
        showingSettings.toggle()
    }


    func completeChore() {
        withAnimation {
            textViewToggle.toggle()
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
