//
//  RingViewModel.swift
//  TechChallenge
//
//  Created by Varun Samuel on 10/4/21.
//

import Foundation

import Foundation

struct RingViewModel {
    let pinnedTransactions: Set<Int>
    let transactions: [TransactionModel]
    
    func ratio(for categoryIndex: Int) -> Double {
        let total = self.transactions.reduce(0.0) { result, transaction in
            if self.pinnedTransactions.contains(transaction.id) {
                return result + transaction.amount
            } else {
                return result + 0.0
            }
        }
        var sum = 0.0
        let category = TransactionModel.Category[categoryIndex]
        for transaction in self.transactions {
            if transaction.category == category && self.pinnedTransactions.contains(transaction.id) {
                sum += transaction.amount
            }
        }
        return (sum / total)
    }
    
    func offset(for categoryIndex: Int) -> Double {
        if categoryIndex == 0 {
            return 0.0
        }
        
        var sum = 0.0
        for i in 0...(categoryIndex - 1) {
            sum += self.ratio(for: i)
        }
       
        return sum
    }
}
