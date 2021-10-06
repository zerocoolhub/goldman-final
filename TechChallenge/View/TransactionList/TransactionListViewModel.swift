//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by Varun Samuel on 10/3/21.
//

import Foundation


class TransactionListViewModel: ObservableObject {
    @Published var state: AppState
    @Published var category: TransactionModel.Category? = nil
    
    init(state: AppState) {
        self.state = state
    }
    
    static func getFilteredTransactions(transactions: [TransactionModel],
                                        category: TransactionModel.Category?) -> [TransactionModel]
    {
        guard let category = category else {
            return transactions
        }
        
        return transactions.filter({ $0.category == category })
    }
    
    static func totalExpendituresForCategory(transactions: [TransactionModel],
                                             pinnedTransactions: Set<Int>,
                                             category: TransactionModel.Category?) -> Double
    {
        var total = 0.0
        if let category = category {
            for transaction in transactions {
                if transaction.category == category && pinnedTransactions.contains(transaction.id) {
                    total += transaction.amount
                }
            }
            return total
        }
            
        for transaction in transactions {
            if pinnedTransactions.contains(transaction.id) {
                total += transaction.amount
            }
        }
        return total
    }
    
    func changeCategory(category: TransactionModel.Category?) {
        self.category = category
    }

    func getFilteredTransactions() -> [TransactionModel] {
        TransactionListViewModel.getFilteredTransactions(transactions: self.state.transactions,
                                                         category: self.category)
    }
    
    func receiveValue(tid: Int) {
        if self.state.pinnedTransactions.contains(tid) {
            self.state.pinnedTransactions.remove(tid)
        } else {
            self.state.pinnedTransactions.insert(tid)
        }
        self.objectWillChange.send()
    }
    
    func isPinned(tid: Int) -> Bool {
        return self.state.pinnedTransactions.contains(tid)
    }
    
    func totalExpenditures() -> Double {
        TransactionListViewModel.totalExpendituresForCategory(transactions: self.state.transactions,
                                                              pinnedTransactions: self.state.pinnedTransactions,
                                                              category: self.category)
    }
}
