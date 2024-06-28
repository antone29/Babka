//
//  TransactionListView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import RealmSwift
import Collections

struct TransactionListView: View {
 
    @State private var searchFilter = ""
    @State private var showingAddTransaction = false
    var transactionListVM = TransactionListViewModel()
    @ObservedResults(Transaction.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var transactions
    @State private var selection = Category.billsAndUtilities
    let categories = Category.categories
    
    
    
    var body: some View {
        VStack {
            Picker("Select a category", selection: $selection) {
                ForEach(categories, id: \.self) {
                    Text($0.name)
                }
            }
//            .pickerStyle(.menu)
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
               
//                ForEach(transactions, id: \.self) { transaction in
//                    NavigationLink(destination: TransactionDetailView(transaction: transaction)){
//                        TransactionRow(transaction: transaction)
//                    }
//                
//                    
//                }
            }
            .searchable(text: $searchFilter,
                                    collection: $transactions,
                        keyPath: \.merchant) {
                            ForEach(transactions) { transactionsFiltered in
                                Text(transactionsFiltered.merchant).searchCompletion(transactionsFiltered.merchant)
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
                ToolbarItem {
                    Image(systemName: "plus.app")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon2, .primary)
                        .onTapGesture {
                            showingAddTransaction.toggle()
                        }
                        .sheet(isPresented: $showingAddTransaction) {
                            AddTransactionView( showingAddTransaction: $showingAddTransaction)
                        }
                }
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    func groupTranactionsByMonth() -> TransactionGroup {
//        //make sure transaction list isnt empty
//        guard !transactions.isEmpty else {
//            return [:]
//        }
//        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.category }
//        return groupedTransactions
//    }
    
//
//    let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
//    let studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
//    func filterTransactionsByCategory(category: Int) -> [Transaction] {
//        //make sure transaction list isnt empty
//        guard !transactions.isEmpty else {
//            return []
//        }
//        let groupTransactions = transactions.filter {
//            $0.categoryId == category
//        }
//        for item in transactions {
//           //
//        }
//        return groupTransactions
//    }
}


//#Preview {
//    TransactionListView()
//}
