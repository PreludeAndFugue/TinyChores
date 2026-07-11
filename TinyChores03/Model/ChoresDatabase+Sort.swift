//
//  ChoresDatabase+Sort.swift
//  TinyChores03
//
//  Created by gary on 04/10/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import Foundation

extension ChoresDatabase {
    enum Sort: String, CaseIterable {
        case name
        case period
        case next
    }
}


extension ChoresDatabase.Sort {
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .next:
            return "Next Due"
        case .period:
            return "Repeat Period"
        }
    }
}
