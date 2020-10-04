//
//  EditChoresMenuButtonView.swift
//  TinyChores03
//
//  Created by gary on 04/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

struct EditChoresMenuButtonView: View {
    typealias Action = () -> Void

    let sort: ChoresDatabase.Sort
    let action: Action
    let selectedSort: ChoresDatabase.Sort


    init(sort: ChoresDatabase.Sort, selectedSort: ChoresDatabase.Sort, action: @escaping Action) {
        self.sort = sort
        self.selectedSort = selectedSort
        self.action = action
    }


    var body: some View {
        Button(action: doSort) {
            Text("Sort by \(sort.name)")
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.purple)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }


    private var isSelected: Bool {
        sort == selectedSort
    }


    private func doSort() {
        action()
    }
}


#if DEBUG
struct EditChoresMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditChoresMenuButtonView(sort: .name, selectedSort: .period, action: {})
    }
}
#endif
