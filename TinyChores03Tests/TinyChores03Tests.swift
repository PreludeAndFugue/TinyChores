//
//  TinyChores03Tests.swift
//  TinyChores03Tests
//
//  Created by gary on 10/09/2020.
//  Copyright © 2020 Gary Kerr. All rights reserved.
//

import XCTest
@testable import TinyChores03

final class TinyChores03Tests: XCTestCase {
    private var defaults: UserDefaults!
    private var suiteName: String!

    override func setUp() {
        super.setUp()

        suiteName = "TinyChores03Tests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        defaults = nil
        suiteName = nil

        super.tearDown()
    }

    func testFinishTargetsTheRequestedChoreRegardlessOfArrayOrder() {
        let database = ChoresDatabase(userDefaults: defaults)
        let referenceDate = Date(timeIntervalSinceReferenceDate: 1_000_000)
        let firstChore = Chore(
            id: UUID(),
            name: "First",
            period: .day,
            date: referenceDate
        )
        let requestedChore = Chore(
            id: UUID(),
            name: "Requested",
            period: .day,
            date: referenceDate.addingTimeInterval(3_600)
        )
        database.chores = [firstChore, requestedChore]

        database.finish(choreID: requestedChore.id)

        XCTAssertEqual(firstChore.date, referenceDate)
        XCTAssertEqual(
            requestedChore.date,
            referenceDate.addingTimeInterval(3_600 + Chore.Period.day.timeInterval)
        )
        XCTAssertEqual(database.chores.first?.id, firstChore.id)
    }

    func testResetUpdatesTheDisplayedChore() {
        let database = ChoresDatabase(userDefaults: defaults)
        let viewModel = MainViewModel(db: database)
        let previousChoreID = viewModel.currentChore?.id

        database.resetChores()

        XCTAssertNotEqual(viewModel.currentChore?.id, previousChoreID)
        XCTAssertEqual(viewModel.currentChore?.id, database.chores.first?.id)
    }
}
