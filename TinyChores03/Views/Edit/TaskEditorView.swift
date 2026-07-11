//
//  TaskEditorView.swift
//  TinyChores03
//

import SwiftUI

struct TaskEditorView: View {
    @EnvironmentObject private var database: ChoresDatabase

    private enum Field {
        case name
    }

    private let chore: Chore?
    private let onDismiss: () -> Void
    @State private var name: String
    @State private var period: Chore.Period
    @FocusState private var focusedField: Field?

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
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.title2.weight(.semibold))

            Form {
                TextField("Task name", text: $name)
                    .focused($focusedField, equals: .name)
                    .onSubmit(saveIfPossible)

                Picker("Repeats every", selection: $period) {
                    ForEach(Chore.Period.allCases) { period in
                        Text(period.name).tag(period)
                    }
                }
            }
            .formStyle(.grouped)

            HStack {
                cancelButton
                Spacer()
                saveButton
            }
        }
        .padding(20)
        .frame(width: 420)
        .onAppear {
            focusedField = .name
        }
    }


    private var cancelButton: some View {
        Button("Cancel", action: dismiss)
            .keyboardShortcut(.cancelAction)
    }


    private var saveButton: some View {
        Button(saveButtonTitle, action: save)
            .keyboardShortcut(.defaultAction)
            .disabled(!canSave)
    }


    private var title: String {
        chore == nil ? "New Task" : "Edit Task"
    }


    private var saveButtonTitle: String {
        chore == nil ? "Add Task" : "Save Changes"
    }


    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }


    private func save() {
        guard canSave else { return }

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if let chore = chore {
            database.update(chore: chore, name: trimmedName, period: period)
        } else {
            database.add(chore: Chore(name: trimmedName, period: period))
        }

        dismiss()
    }


    private func saveIfPossible() {
        guard canSave else { return }
        save()
    }


    private func dismiss() {
        onDismiss()
    }
}
