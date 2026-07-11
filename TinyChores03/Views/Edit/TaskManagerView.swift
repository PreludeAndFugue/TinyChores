//
//  TaskManagerView.swift
//  TinyChores03
//

import SwiftUI

struct TaskManagerView: View {
    @EnvironmentObject private var database: ChoresDatabase
    @SceneStorage("tasks.sort") private var sortName = ChoresDatabase.Sort.next.rawValue
    @State private var selection: Chore.ID?
    @State private var editor: TaskEditorSheet?

    var body: some View {
        Group {
            if database.chores.isEmpty {
                emptyState
            } else {
                taskList
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: addTask) {
                    Label("New Task", systemImage: "plus")
                }
                .keyboardShortcut("n")
                .help("New Task")

                Button(action: editSelectedTask) {
                    Label("Edit Task", systemImage: "pencil")
                }
                .disabled(selectedTask == nil)
                .help("Edit Selected Task")

                Button(role: .destructive, action: deleteSelectedTask) {
                    Label("Delete Task", systemImage: "trash")
                }
                .disabled(selectedTask == nil)
                .help("Delete Selected Task")

                Menu {
                    ForEach(ChoresDatabase.Sort.allCases, id: \.self) { option in
                        Button(action: { sort(by: option) }) {
                            if option == currentSort {
                                Label(option.title, systemImage: "checkmark")
                            } else {
                                Text(option.title)
                            }
                        }
                    }
                } label: {
                    Label("Sort Tasks", systemImage: "arrow.up.arrow.down")
                }
                .help("Sort Tasks")
            }
        }
        .sheet(item: $editor) { sheet in
            TaskEditorView(chore: sheet.chore, onDismiss: { editor = nil })
                .environmentObject(database)
        }
        .onDeleteCommand(perform: deleteSelectedTask)
        .tint(.purple)
    }


    private var taskList: some View {
        List(selection: $selection) {
            ForEach(database.chores) { chore in
                TaskRow(chore: chore)
                    .tag(chore.id)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        edit(chore)
                    }
                    .contextMenu {
                        Button("Edit…") {
                            edit(chore)
                        }

                        Divider()

                        Button("Delete", role: .destructive) {
                            delete(chore)
                        }
                    }
            }
            .onDelete(perform: deleteTasks)
        }
        .listStyle(.inset)
    }


    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.system(size: 36))
                .foregroundStyle(.secondary)

            Text("No Tasks")
                .font(.title3.weight(.semibold))

            Text("Create a task to get started.")
                .foregroundStyle(.secondary)

            Button("New Task", action: addTask)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    private var currentSort: ChoresDatabase.Sort {
        ChoresDatabase.Sort(rawValue: sortName) ?? .next
    }


    private var selectedTask: Chore? {
        guard let selectedID = selection else { return nil }
        return database.chores.first(where: { $0.id == selectedID })
    }


    private func addTask() {
        editor = .new
    }


    private func editSelectedTask() {
        guard let selectedTask else { return }
        edit(selectedTask)
    }


    private func edit(_ chore: Chore) {
        selection = chore.id
        editor = .edit(chore)
    }


    private func deleteSelectedTask() {
        guard let selectedTask else { return }
        delete(selectedTask)
    }


    private func delete(_ chore: Chore) {
        database.remove(chore: chore)
        if selection == chore.id {
            selection = nil
        }
    }


    private func deleteTasks(at offsets: IndexSet) {
        database.remove(indexSet: offsets)

        if selectedTask == nil {
            selection = nil
        }
    }


    private func sort(by option: ChoresDatabase.Sort) {
        sortName = option.rawValue

        withAnimation {
            database.sort(by: option)
        }
    }
}

private struct TaskRow: View {
    let chore: Chore

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(chore.name)
                .fontWeight(.medium)

            Text("Repeats every \(chore.period.name)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 3)
    }
}

private enum TaskEditorSheet: Identifiable {
    case new
    case edit(Chore)

    var id: String {
        switch self {
        case .new:
            return "new"
        case .edit(let chore):
            return chore.id.uuidString
        }
    }

    var chore: Chore? {
        switch self {
        case .new:
            return nil
        case .edit(let chore):
            return chore
        }
    }
}
