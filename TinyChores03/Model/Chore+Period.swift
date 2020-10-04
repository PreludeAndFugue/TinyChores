//
//  Chore+Period.swift
//  TinyChores01
//
//  Created by gary on 02/06/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Foundation

extension Chore {
    enum Period: Int, CaseIterable, Codable {
        case halfDay = 43_200
        case day = 86_400
        case twoDays = 172_800
        case threeDays = 259_200
        case oneWeek = 604_800
    }
}


extension Chore.Period {
    var timeInterval: TimeInterval {
        return TimeInterval(rawValue)
    }


    var name: String {
        switch self {
        case .halfDay:
            return "Half day"
        case .day:
            return "Day"
        case .twoDays:
            return "Two days"
        case .threeDays:
            return "Three days"
        case .oneWeek:
            return "One Week"
        }
    }
}


extension Chore.Period: Identifiable {
    var id: Int {
        rawValue
    }
}


extension Chore.Period: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
