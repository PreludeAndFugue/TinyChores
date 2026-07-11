//
//  TaskEditorView.swift
//  TinyChores03
//

import SwiftUI

struct TaskEditorView: View {
    @EnvironmentObject private var database: ChoresDatabase

    private let chore: Chore?
    private let onDismiss: () -> Void
    @State private var name: String
    @State private var period: Chore.Period

    init(chore: Chore? = nil, onDismiss: @escaping () -> Void) {
        self.chore = chore
        self.onDismiss = onDismiss
        _name = State(initialValue: chore?.name ?? "")
        _period = State(initialValue: chore?.period ?? .day)
    }

    var body: some View {
        macOSContent
    }


    private var macOSContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)

            TextField("Task name", text: $name)

            Picker("Repeat", selection: $period) {
                ForEach(Chore.Period.allCases) { period in
                    Text(period.name).tag(period)
                }
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


    private var cancelButton: some View {
        Button("Cancel", action: dismiss)
            .keyboardShortcut(.cancelAction)
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
        onDismiss()
    }
}
