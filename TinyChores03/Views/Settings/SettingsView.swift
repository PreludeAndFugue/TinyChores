//
//  SettingsView.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var db: ChoresDatabase
    @State private var showingResetConfirmation = false

    var body: some View {
        Form {
            Section("Data") {
                Text("Restore the original task list and remove any changes you have made.")
                    .foregroundStyle(.secondary)

                Button("Reset All Tasks…", role: .destructive) {
                    showingResetConfirmation = true
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 460, height: 180)
        .scenePadding()
        .tint(.purple)
        .alert("Reset all tasks?", isPresented: $showingResetConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                db.resetChores()
            }
        } message: {
            Text("This restores the original task list and cannot be undone.")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
