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


    @State var opacity = 1.0
    @State var scale: CGFloat = 1
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            SettingsButtonView(action: showSettings)

            ZStack(alignment: .bottomTrailing) {
                MainTextView(name: viewModel.currentChore.name)
                    .opacity(opacity)
                    .scaleEffect(scale)

                NextButtonView(action: completeChore)
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }


    func showSettings() {
        print("show settings")
        showingSettings.toggle()
    }


    func completeChore() {
        withAnimation {
            opacity = 0
            scale = 5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            scale = 0.01
            withAnimation() {
                viewModel.finishChore()
                opacity = 1
                scale = 1
            }
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
