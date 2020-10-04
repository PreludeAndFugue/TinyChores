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

    init(db: ChoresDatabase) {
        self.db = db
    }


    var chores: [Chore] {
        db.chores
    }


    func deleteChore(indexSet: IndexSet) {
        db.remove(indexSet: indexSet)
    }


    func sort(by sort: ChoresDatabase.Sort) {
        db.sort(by: sort)
    }
}
