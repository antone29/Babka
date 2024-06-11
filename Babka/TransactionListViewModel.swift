//
//  TransactionListViewModel.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/11/24.
//

import Foundation
import Combine
import RealmSwift
import SwiftUI
import Collections //needed for OrderedDictionary, needs to be added



typealias TransactionGroup = OrderedDictionary<String,  [Transaction]> //ordered will show things as they are added, so shows most recent without us having to sort

typealias TransactionPrefixSum = [(String, Double)]

//class TransactionListViewModel: DynamicProperty , ObservableObject{
struct TransactionListViewModel: DynamicProperty {
  //  @Published var transactions: [Transaction] = []
    @ObservedResults(Transaction.self, sortDescriptor: SortDescriptor(keyPath: "_id", ascending: true)) var transactions
    private var cancellables = Set<AnyCancellable>()
    
    
    
//    func groupTranactionsByMonth() -> TransactionGroup {
//        //make sure transaction list isnt empty
//        guard !transactions.isEmpty else {
//            return [:]
//        }
//        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.date }
//        return groupedTransactions
//    }
    
    func groupTransactionsByCategory() ->TransactionGroup {
        //make sure transaction list isnt empty
        guard !transactions.isEmpty else {
            return [:]
        }
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.category }
//        let groupTransactions = transactions.filter {
//            $0.categoryId == category
//        }
        return groupedTransactions
    }
    
//    func accumulateTransactions() -> TransactionPrefixSum {
//        print("accumulate transactions")
//        guard !transactions.isEmpty else {return [] }
//        
//        let today = "02/20/2022".dateParsed() //Date()
//        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
//        print("dateinterval ", dateInterval)
//        
//        var sum: Double = .zero
//        var cumulaticeSum = TransactionPrefixSum()
//        
//        for date in stride(from: dateInterval.start, through: today, by: 60 * 60 * 24){
//            let dailyExpenses = transactions.filter{ $0.dateParsed == date && $0.isExpense  }
//            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
//            sum += dailyTotal
//            sum = sum.roundedTo2Digits()
//            cumulaticeSum.append((date.formatted(), sum))
//            print(date.formatted(), " dailyTotal: ", dailyTotal, " sum: ", sum)
//            
//        }
//        
//        return cumulaticeSum
//    }
}
