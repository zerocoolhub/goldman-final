//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI
import Combine

struct TransactionListView: View {
    @ObservedObject var vm: TransactionListViewModel
    
    var body: some View {
        ZStack {
            VStack {
                ButtonListView(buttonCallback: vm.changeCategory(category:))
                
                List {
                    ForEach(vm.getFilteredTransactions()) { transaction in
                        TransactionView(transaction: transaction,
                                        isPinned: self.vm.isPinned(tid: transaction.id),
                                        buttonCallback: self.vm.receiveValue(tid:))
                    }
                    Spacer().frame(height: 80)
                }
                .animation(.easeIn)
                .listStyle(PlainListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Transactions")
            }
            VStack {
                Spacer()
                FloatingSumView(category: vm.category?.rawValue ?? "all",
                                categoryColor: vm.category?.color ?? Color.black,
                                price: vm.totalExpenditures())
                    .padding(5)
            }
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(vm: TransactionListViewModel(state: AppState()))
    }
}
#endif
