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
        .onDisappear(perform: sortByNext)
    }


    private var trailingButtons: some View {
        HStack(spacing: 16) {
            Menu() {
                Button(action: sortByName) {
                    Text("Sort by name")
                    if viewModel.isSortByName {
                        Image(systemName: "checkmark")
                    }
                }
                Button(action: sortByPeriod) {
                    Text("Sort by period")
                    if viewModel.isSortByPeriod {
                        Image(systemName: "checkmark")
                    }
                }
                Button(action: sortByNext) {
                    Text("Sort by next")
                    if viewModel.isSortByNext {
                        Image(systemName: "checkmark")
                    }
                }
            } label: {
                Image(systemName: "list.triangle")
            }

            Button(action: addChore) {
                Image(systemName: "plus")
            }
        }
        .foregroundColor(.purple)
        .buttonStyle(PlainButtonStyle())
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


// MARK: - Sorting

private extension EditChoresView {
    private func sortByName() {
        withAnimation() {
            viewModel.sort(by: .name)
        }
    }


    private func sortByPeriod() {
        withAnimation() {
            viewModel.sort(by: .period)
        }
    }


    private func sortByNext() {
        withAnimation() {
            viewModel.sort(by: .next)
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
