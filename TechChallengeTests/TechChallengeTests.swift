//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

let transaction1 = TransactionModel(
    id: 1,
    name: "Movie Night",
    category: .entertainment,
    amount: 82.99,
    date: Date(string: "2021-03-05")!,
    accountName: "account name",
    provider: .timeWarner
)

let transaction2 = TransactionModel(
    id: 2,
    name: "Jeans",
    category: .shopping,
    amount: 54.60,
    date: Date(string: "2021-04-25")!,
    accountName: "account name2",
    provider: .jCrew
)

class TechChallengeTests: XCTestCase {
    let transactions = [transaction1, transaction2]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilterTransactions() {
        let res = TransactionListViewModel.getFilteredTransactions(transactions: transactions, category: .entertainment)
        XCTAssertEqual(res, [transaction1])
    }
    
    func testSumTransactionsUnPinned() {
        let res = TransactionListViewModel.totalExpendituresForCategory(transactions: transactions,
                                                                        pinnedTransactions: Set(),
                                                                        category: .entertainment)
        XCTAssertEqual(res, 0.0)
    }
    
    func testSumTransactionsPinned() {
        var pinned = Set<Int>()
        pinned.insert(1)
        let res = TransactionListViewModel.totalExpendituresForCategory(transactions: transactions,
                                                                        pinnedTransactions: pinned,
                                                                        category: .entertainment)
        XCTAssertEqual(res, 82.99)
    }
}
