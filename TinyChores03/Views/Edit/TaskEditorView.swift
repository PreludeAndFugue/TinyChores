//
//  TaskEditorView.swift
//  TinyChores03
//

import SwiftUI

struct TaskEditorView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var database: ChoresDatabase

    private let chore: Chore?
    @State private var name: String
    @State private var period: Chore.Period

    init(chore: Chore? = nil) {
        self.chore = chore
        _name = State(initialValue: chore?.name ?? "")
        _period = State(initialValue: chore?.period ?? .day)
    }

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
            Text(title)
                .font(.headline)

            Form {
                editorFields
            }

            HStack {
                Spacer()
                cancelButton
                saveButton
            }
        }
        .padding()
        .frame(width: 360)
    }
    #endif


    #if os(iOS)
    private var iOSContent: some View {
        NavigationView {
            Form {
                editorFields
            }
            .navigationTitle(title)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    #endif


    private var editorFields: some View {
        Section {
            TextField("Task name", text: $name)
            Picker("Repeat", selection: $period) {
                ForEach(Chore.Period.allCases) { period in
                    Text(period.name).tag(period)
                }
            }
        }
    }


    private var cancelButton: some View {
        Button("Cancel", action: dismiss)
    }


    private var saveButton: some View {
        Button("Save", action: save)
            .disabled(!canSave)
    }


    private var title: String {
        chore == nil ? "New Task" : "Edit Task"
    }


    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }


    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if let chore = chore {
            database.update(chore: chore, name: trimmedName, period: period)
        } else {
            database.add(chore: Chore(name: trimmedName, period: period))
        }

        dismiss()
    }


    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
