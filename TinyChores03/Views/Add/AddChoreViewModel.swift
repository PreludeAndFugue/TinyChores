//
//  AddChoreViewModel.swift
//  TinyChores03
//
//  Created by gary on 22/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Combine

final class AddChoreViewModel: ObservableObject {
    private let db: ChoresDatabase

    let periodNames = Chore.Period.allCases.map({ $0.name })

    @Published var name = ""
    @Published var selectedPeriod = 0

    var canSave: Bool {
        name.count > 2
    }


    init(db: ChoresDatabase) {
        self.db = db
    }


    func save() {
        let period = Chore.Period.allCases[selectedPeriod]
        let chore = Chore(name: name, period: period)
        db.add(chore: chore)
    }
}
