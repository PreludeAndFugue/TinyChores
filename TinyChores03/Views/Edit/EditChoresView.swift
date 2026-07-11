//
//  EditChoresView.swift
//  TinyChores03
//
//  Created by gary on 20/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct EditChoresView: View {
    @EnvironmentObject var db: ChoresDatabase
    @State private var editor: TaskEditorSheet?
    @StateObject var viewModel: EditChoresViewModel

    
    var body: some View {
        #if os(macOS)
        macOSContent
        #else
        iOSContent
        #endif
    }


    #if os(macOS)
    private var macOSContent: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Tasks")
                    .font(.headline)
                Spacer()
                trailingButtons
            }
            .padding([.top, .horizontal])

            choreList
                .listStyle(.inset)
        }
    }
    #endif


    #if os(iOS)
    private var iOSContent: some View {
        choreList
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Tasks")
            .navigationBarItems(trailing: trailingButtons)
    }
    #endif


    private var choreList: some View {
        List {
            ForEach(viewModel.chores) { chore in
                taskRow(chore)
            }
            .onDelete(perform: deleteChore)
        }
        .sheet(item: $editor) { sheet in
            TaskEditorView(chore: sheet.chore)
                .environmentObject(db)
        }
        .onDisappear {
            viewModel.sort(by: .next)
        }
    }


    private var trailingButtons: some View {
        HStack(spacing: 16) {
            EditChoresMenuView(sort: viewModel.sort, sorter: viewModel.sort(by:), addChore: addChore)
            #if os(iOS)
            EditButton()
            #endif
        }
    }
}


// MARK: - Editing chores

private extension EditChoresView {
    func taskRow(_ chore: Chore) -> some View {
        Button(action: { editor = .edit(chore) }) {
            HStack(spacing: 12) {
                ChoreView(chore: chore)
                Image(systemName: "pencil")
                    .foregroundColor(.secondary)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .contextMenu {
            Button(action: { editor = .edit(chore) }) {
                Text("Edit")
            }
            Button(action: { db.remove(chore: chore) }) {
                Text("Delete")
            }
        }
        .accessibilityLabel("Edit \(chore.name)")
    }


    private func addChore() {
        editor = .new
    }


    private func deleteChore(indexSet: IndexSet?) {
        guard let indexSet = indexSet else { return }
        viewModel.deleteChore(indexSet: indexSet)
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


#if DEBUG
struct EditChoresView_Previews: PreviewProvider {
    static let vm = EditChoresViewModel(db: .init(userDefaults: .standard))

    static var previews: some View {
        NavigationView {
            EditChoresView(viewModel: vm)
        }
    }
}
#endif
