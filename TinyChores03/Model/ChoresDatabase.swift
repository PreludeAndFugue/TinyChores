//
//  ChoresDatabase.swift
//  TinyChores01
//
//  Created by gary on 02/06/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Foundation
import Combine

private let defaultsKey = "ChoresDatabase.Chores"

final class ChoresDatabase: ObservableObject {
    enum Sort {
        case name
        case period
        case next
    }


    private let userDefaults: UserDefaults

    @Published var chores: [Chore]


    init(userDefaults: UserDefaults) {
        print("ChoresDatabase.init")
        self.userDefaults = userDefaults
        self.chores = load(from: userDefaults)
    }


    func finishCurrentChore() {
        objectWillChange.send()
        chores.first!.finish()
        chores.sort(by: { $0.date < $1.date })
        save()
    }


    func add(chore: Chore) {
        chores.append(chore)
        chores.sort(by: { $0.date < $1.date })
        save()
    }


    func remove(indexSet: IndexSet) {
        chores.remove(atOffsets: indexSet)
        save()
    }


    func resetChores() {
        chores = Self.initialChores
        save()
    }


    func sort(by sort: Sort) {
        switch sort {
        case .name:
            chores.sort(by: { $0.name < $1.name })
        case .period:
            chores.sort(by: { $0.period < $1.period })
        case .next:
            chores.sort(by: { $0.date < $1.date })
        }
    }
}


// MARK: - Private

private extension ChoresDatabase {
    func save() {
        guard let data = try? JSONEncoder().encode(chores) else { return }
        userDefaults.set(data, forKey: defaultsKey)
    }
}


private extension ChoresDatabase {
    static let initialChores: [Chore] = [
        Chore(id: UUID(), name: "Clean dishes", period: .halfDay, date: Date()),
        Chore(id: UUID(), name: "Clean bathroom sink", period: .day, date: Date()),
        Chore(id: UUID(), name: "Clean toilet", period: .day, date: Date()),
        Chore(id: UUID(), name: "Clean bath", period: .day, date: Date()),
        Chore(id: UUID(), name: "Dust upstairs", period: .day, date: Date()),
        Chore(id: UUID(), name: "Dust downstairs", period: .day, date: Date()),
        Chore(id: UUID(), name: "Hoover upstairs", period: .day, date: Date()),
        Chore(id: UUID(), name: "Hoover downstairs", period: .day, date: Date()),
        Chore(id: UUID(), name: "Empty recycling", period: .threeDays, date: Date()),
        Chore(id: UUID(), name: "Clean desk", period: .oneWeek, date: Date()),
        Chore(id: UUID(), name: "Change pillow covers", period: .threeDays, date: Date()),
        Chore(id: UUID(), name: "Change sheets", period: .oneWeek, date: Date()),
        Chore(id: UUID(), name: "Weed garden", period: .threeDays, date: Date()),
        Chore(id: UUID(), name: "Weed front door", period: .oneWeek, date: Date())
    ]
}


private func load(from userDefaults: UserDefaults) -> [Chore] {
    guard let data = userDefaults.data(forKey: defaultsKey) else {
        return ChoresDatabase.initialChores
    }
    let decoder = JSONDecoder()
    return (try? decoder.decode([Chore].self, from: data)) ?? ChoresDatabase.initialChores
}
