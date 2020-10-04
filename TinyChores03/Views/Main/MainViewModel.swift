//
//  MainViewModel.swift
//  TinyChores03
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Combine

final class MainViewModel: ObservableObject {
    private let db: ChoresDatabase

    @Published var currentChore: Chore


    init(db: ChoresDatabase) {
        self.db = db
        self.currentChore = db.chores.first!
    }


    func finishChore() {
        db.finishCurrentChore()
        currentChore = db.chores.first!
    }
}
