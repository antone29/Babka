//
//  TransactionRow.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import SwiftUIFontIcon



struct TransactionRow: View {
//    var transaction: Transaction
    var transaction: Transaction2
   
    
    
    var body: some View {
        HStack(spacing: 20){
            // MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style:  .continuous)
                .fill(Color.icon2.opacity(0.3))
                .frame(width: 44, height: 44)
//                .overlay{
//                    //using custom icons
//                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon2)
//                }
            
            VStack(alignment: .leading, spacing: 6 ){
                // MARK: Transaction Merchant
              //  Text(transaction.merchant)
                Text(transaction.name)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Transaction Date
//                Text(transaction.date.dateParsed())
                Text(transaction.date)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    
            }
            
            Spacer()
            
            // MARK: Transaction Amount
           // Text(transaction.signedAmount, format: .currency(code: "USD"))
            Text(transaction.amount, format: .currency(code: "USD"))
                .bold()
//                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text2 : .primary)
            
        }
        .padding([.top, .bottom], 8)
        
    }
}
