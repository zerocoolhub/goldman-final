//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Varun Samuel on 10/5/21.
//

import Foundation

struct InsightsViewModel {
    var state: AppState
    
    func totalCategoryExpense(category: TransactionModel.Category) -> Double {
        let total = state.transactions.reduce(0.0) { result, transaction in
            if (transaction.category == category) &&
                (self.state.pinnedTransactions.contains(transaction.id))
            {
                return result + transaction.amount
            } else {
                return result + 0.0
            }
        }

        return total
    }
}
