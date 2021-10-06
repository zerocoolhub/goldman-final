//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI
import Combine

struct ButtonListView: View {
    var buttonCallback: ((TransactionModel.Category?) -> Void)?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Button(action: {
                    if let c = buttonCallback {
                        c(nil)
                    }
                }, label: {
                    Text("all")
                        .foregroundColor(Color.white)
                        .font(Font.system(.title2))
                        .fontWeight(.bold)
                        .frame(width: 50, height: 20)
                        .padding(15)
                        .background(Color.black)
                        .clipShape(
                            Capsule()
                        )
                })
                
                ForEach(TransactionModel.Category.allCases) { category in
                    Button(action: {
                        if let c = buttonCallback {
                            c(category)
                        }
                    }, label: {
                        Text(category.rawValue)
                            .foregroundColor(Color.white)
                            .font(Font.system(.title2))
                            .fontWeight(.bold)
                            .frame(height: 20)
                            .padding(15)
                            .background(category.color)
                            .clipShape(
                                Capsule()
                            )
                    })
                }
            }
            .frame(height: 80)
        }
        .background(Color.accentColor)
        .opacity(0.8)
    }
}

#if DEBUG
struct ButtonListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonListView()
            Spacer()
        }
    }
}
#endif
