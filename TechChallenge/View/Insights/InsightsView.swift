//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var state: AppState
    
    let vm: InsightsViewModel
    
    init(vm: InsightsViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        List {
            RingView(vm: RingViewModel(pinnedTransactions: state.pinnedTransactions,
                                       transactions: state.transactions))
                .scaledToFit()
            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    // TODO: calculate cummulative expense for each category
                    let catExp = self.vm.totalCategoryExpense(category: category)
                    let formatted = String(format: "%.2f", catExp)
                    Text("$\(formatted)")
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(vm: InsightsViewModel(state: AppState()))
            .previewLayout(.sizeThatFits)
    }
}
#endif
