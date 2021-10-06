//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI
import Combine

struct TransactionView: View {
    let transaction: TransactionModel
    let isPinned: Bool
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                if let c = self.buttonCallback {
                    c(transaction.id)
                }
            }
    }
    var buttonCallback: ((Int) -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.rawValue)
                    .font(.headline)
                    .foregroundColor(transaction.category.color)
                Spacer()
                Image(systemName: isPinned ? "pin.fill" : "pin.slash.fill")
            }
            
            if (isPinned) {
                HStack {
                    transaction.image
                        .resizable()
                        .frame(
                            width: 60.0,
                            height: 60.0,
                            alignment: .top
                        )
                    
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                            .secondary()
                        Text(transaction.accountName)
                            .tertiary()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("$\(transaction.amount.formatted())")
                            .bold()
                            .secondary()
                        Text(transaction.date.formatted)
                            .tertiary()
                    }
                }
            }
        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .gesture(tap)
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TransactionView(transaction: ModelData.sampleTransactions[0], isPinned: true)
            TransactionView(transaction: ModelData.sampleTransactions[1], isPinned: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
