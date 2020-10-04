//
//  EditChoresViewModel.swift
//  TinyChores03
//
//  Created by gary on 20/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import SwiftUI

final class EditChoresViewModel: ObservableObject {
    private let db: ChoresDatabase
    private var sort: ChoresDatabase.Sort = .next

    init(db: ChoresDatabase) {
        self.db = db
    }


    var chores: [Chore] {
        db.chores
    }


    var isSortByName: Bool {
        sort == .name
    }


    var isSortByNext: Bool {
        sort == .next
    }


    var isSortByPeriod: Bool {
        sort == .period
    }


    func deleteChore(indexSet: IndexSet) {
        db.remove(indexSet: indexSet)
    }


    func sort(by sort: ChoresDatabase.Sort) {
        self.sort = sort
        db.sort(by: sort)
    }
}
