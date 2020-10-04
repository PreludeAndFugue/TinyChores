//
//  EditChoresMenuView.swift
//  TinyChores03
//
//  Created by gary on 04/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct EditChoresMenuView: View {
    private let viewModel: EditChoresMenuViewModel


    init(sort: ChoresDatabase.Sort, sorter: @escaping EditChoresMenuViewModel.Sorter, addChore: @escaping EditChoresMenuViewModel.AddChore) {
        self.viewModel = EditChoresMenuViewModel(sort: sort, sorter: sorter, addChore: addChore)
    }


    var body: some View {
        HStack(spacing: 16) {
            Menu() {
                EditChoresMenuButtonView(sort: .name, selectedSort: viewModel.sort) {
                    viewModel.sorter(.name)
                }
                EditChoresMenuButtonView(sort: .period, selectedSort: viewModel.sort) {
                    viewModel.sorter(.period)
                }
                EditChoresMenuButtonView(sort: .next, selectedSort: viewModel.sort) {
                    viewModel.sorter(.next)
                }
            } label: {
                Image(systemName: "list.triangle")
            }

            Button(action: viewModel.addChore) {
                Image(systemName: "plus")
            }
        }
        .foregroundColor(.purple)
        .buttonStyle(PlainButtonStyle())
    }
}


#if DEBUG
struct EditChoresMenuView_Previews: PreviewProvider {
    static var previews: some View {
        EditChoresMenuView(sort: .next, sorter: { _ in }, addChore: {})
    }
}
#endif
