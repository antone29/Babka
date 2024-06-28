//
//  CategoryView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import RealmSwift

struct CategoryView: View {
    var transactionListVM = TransactionListViewModel()
    @ObservedResults(Transaction.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var transactions
    
    
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Groups
                ForEach(Array(transactionListVM.groupTransactionsByCategory()), id: \.key) { month,
                    transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                            
                        }
                    } header: {
                        // MARK: Transaction month
                        Text(month)
                    }.listSectionSeparator(.hidden)
            
                }
               
            }

            .listStyle(.plain)
            .toolbar {
                // MARK: Notification Icon
                //                ToolbarItem {
                //                    Image(systemName: "bell.badge")
                //                        .symbolRenderingMode(.palette)
                //                        .foregroundStyle(Color.icon2, .primary)
                //                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoryView()
}
