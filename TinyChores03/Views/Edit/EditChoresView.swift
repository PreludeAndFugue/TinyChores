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
    @State var isCreatingChore = false
    @StateObject var viewModel: EditChoresViewModel

    
    var body: some View {
        List {
            ForEach(viewModel.chores) { chore in
                ChoreView(chore: chore)
            }
            .onDelete(perform: deleteChore)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Edit")
        .navigationBarItems(trailing: trailingButtons)
        .sheet(isPresented: $isCreatingChore) {
            AddChoreView(viewModel: AddChoreViewModel(db: db))
        }
        .onDisappear {
            viewModel.sort(by: .next)
        }
    }


    private var trailingButtons: some View {
        EditChoresMenuView(sort: viewModel.sort, sorter: viewModel.sort(by:), addChore: addChore)
    }
}


// MARK: - Editing chores

private extension EditChoresView {
    private func addChore() {
        isCreatingChore.toggle()
    }


    private func deleteChore(indexSet: IndexSet?) {
        guard let indexSet = indexSet else { return }
        viewModel.deleteChore(indexSet: indexSet)
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
