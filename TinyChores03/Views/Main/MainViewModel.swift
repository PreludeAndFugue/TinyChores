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
    private var choresSubscription: AnyCancellable?

    @Published var currentChore: Chore?


    init(db: ChoresDatabase) {
        self.db = db
        self.currentChore = db.chores.first
        self.choresSubscription = db.$chores
            .dropFirst()
            .sink { [weak self] chores in
                self?.synchronizeCurrentChore(with: chores)
            }
    }


    func finishChore() {
        guard let currentChore else { return }

        db.finish(choreID: currentChore.id)
        self.currentChore = db.chores.first
    }


    private func synchronizeCurrentChore(with chores: [Chore]) {
        guard let currentChore,
              let refreshedChore = chores.first(where: { $0.id == currentChore.id })
        else {
            self.currentChore = chores.first
            return
        }

        self.currentChore = refreshedChore
    }
}
