//
//  SettingsView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var db: ChoresDatabase
    @State var shouldReset = false

    var body: some View {
        #if os(macOS)
        macOSContent
        #else
        iOSContent
        #endif
    }


    #if os(macOS)
    private var macOSContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Settings")
                .font(.headline)

            Button(action: canResetChores) {
                Text("Reset chores")
                    .foregroundColor(.purple)
            }

            HStack {
                Spacer()
                doneButton
            }
        }
        .padding()
        .frame(width: 320)
        .alert(isPresented: $shouldReset, content: {
            shouldResetAlert
        })
    }
    #endif


    #if os(iOS)
    private var iOSContent: some View {
        NavigationView {
            List {
//                NavigationLink(
//                    destination: EditChoresView(viewModel: .init(db: self.db)),
//                    label: {
//                        Text("Edit chores")
//                })

                Button(action: canResetChores, label: {
                    Text("Reset chores")
                        .foregroundColor(.purple)
                })
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .navigationBarItems(trailing: doneButton)
            .alert(isPresented: $shouldReset, content: {
                shouldResetAlert
            })
        }
    }
    #endif


    var doneButton: some View {
        Button(action: doneEditing) {
            Text("Done")
                .foregroundColor(.purple)
        }
    }


    var shouldResetAlert: Alert {
        Alert(
            title: Text("Reset Chores"),
            message: Text("Do you want to reset chores to initial state"),
            primaryButton: .cancel(Text("No")),
            secondaryButton: .destructive(Text("Yes"), action: resetChores)
        )
    }


    func doneEditing() {
        presentationMode.wrappedValue.dismiss()
    }


    func canResetChores() {
        shouldReset = true
    }


    func resetChores() {
        db.resetChores()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
