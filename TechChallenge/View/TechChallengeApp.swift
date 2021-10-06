//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

class AppState: ObservableObject {
    let transactions: [TransactionModel]
    @Published var pinnedTransactions: Set<Int>
    
    init() {
        let transactions = ModelData.sampleTransactions
        self.transactions = transactions
        self.pinnedTransactions = Set(transactions.map({ $0.id }))
    }
}

@main
struct TechChallengeApp: App {
    var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(vm: TransactionListViewModel(state: appState))
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(vm: InsightsViewModel(state: appState))
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
            .environmentObject(appState)
        }
    }
}
