//
//  ChoresDatabase+Sort.swift
//  TinyChores03
//
//  Created by gary on 04/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Foundation

extension ChoresDatabase {
    enum Sort {
        case name
        case period
        case next
    }
}


extension ChoresDatabase.Sort {
    var name: String {
        switch self {
        case .name:
            return "name"
        case .next:
            return "next"
        case .period:
            return "period"
        }
    }
}
