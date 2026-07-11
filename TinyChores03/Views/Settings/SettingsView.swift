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
    @State private var isManagingTasks = false

    var body: some View {
        macOSContent
    }


    private var macOSContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Settings")
                .font(.headline)

            Button(action: { isManagingTasks = true }) {
                Text("Manage tasks")
            }

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
        .sheet(isPresented: $isManagingTasks) {
            EditChoresView(viewModel: .init(db: db))
                .environmentObject(db)
                .frame(minWidth: 480, minHeight: 420)
        }
        .alert(isPresented: $shouldReset, content: {
            shouldResetAlert
        })
    }


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
