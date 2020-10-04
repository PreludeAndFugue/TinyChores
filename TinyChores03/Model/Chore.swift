//
//  Chore.swift
//  TinyChores01
//
//  Created by gary on 02/06/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Foundation

final class Chore: Identifiable, Codable {
    let id: UUID
    let name: String
    let period: Period
    var date: Date

    init(id: UUID, name: String, period: Period, date: Date) {
        self.id = id
        self.name = name
        self.period = period
        self.date = date
    }

    init(name: String, period: Period) {
        self.id = UUID()
        self.name = name
        self.period = period
        self.date = Date()
    }

    var periodName: String {
        period.name
    }
}


extension Chore {
    func finish() {
        date = date.addingTimeInterval(period.timeInterval)
    }
}


extension Chore: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Chore(id: \(id), name: \(name), period: \(period), date: \(date))"
    }
}
