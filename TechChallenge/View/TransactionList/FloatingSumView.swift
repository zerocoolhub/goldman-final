//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI
import Combine

struct FloatingSumView: View {
    let category: String
    let categoryColor: Color
    let price: Double
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(category)
                    .font(.system(.headline))
                    .foregroundColor(categoryColor)
            }
            HStack {
                Text("Total Spent:")
                    .font(.system(.body))
                    .fontWeight(.regular)
                    .secondary()
                Spacer()
                let formatted = String(format: "%.2f", price)
                Text("$\(formatted)")
                    .font(.system(.body))
                    .fontWeight(Font.Weight.bold)
                    .secondary()
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.accentColor, lineWidth: 2)
        )
    }
}

#if DEBUG
struct FloatingSumView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            FloatingSumView(category: TransactionModel.Category.food.rawValue,
                            categoryColor: TransactionModel.Category.food.color,
                            price: 2.993233)
        }
        .background(Color.black)
    }
}
#endif
