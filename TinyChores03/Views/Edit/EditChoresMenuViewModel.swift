//
//  EditChoresMenuViewModel.swift
//  TinyChores03
//
//  Created by gary on 04/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Combine

final class EditChoresMenuViewModel: ObservableObject {
    typealias Sorter = (ChoresDatabase.Sort) -> Void
    typealias AddChore = () -> Void

    let sort: ChoresDatabase.Sort
    let sorter: Sorter
    let addChore: AddChore


    init(sort: ChoresDatabase.Sort, sorter: @escaping Sorter, addChore: @escaping AddChore) {
        self.sort = sort
        self.sorter = sorter
        self.addChore = addChore
    }


    var isSortByName: Bool {
        return sort == .name
    }


    var isSortByPeriod: Bool {
        sort == .period
    }


    var isSortByNext: Bool {
        sort == .next
    }
}
