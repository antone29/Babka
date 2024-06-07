//
//  AddTransactionView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import RealmSwift

struct AddTransactionView: View {
    @ObservedResults(Transaction.self) var transactions
    @Environment(\.realm) var realm
    @EnvironmentObject var errorHandler: ErrorHandler
    @Binding var showingAddTransaction: Bool
    
    
    @State var merchant = ""
    @State var date = Date()
    @State var amount = 0.0
    @State var category = Category.autoAndTransport
    //@State var subCategory = Category.publicTransportation

    @State private var currency = "USD"
    let currencies = ["PLN", "USD", "EUR", "GBP", "JPY"]//do i need this?
    
    @State private var newTransaction = Transaction()

    var body: some View {
        Form {
            
            Section {
                TextField("location", text: $merchant)
            } header: {
                Text("Add a location")
            }
            
            Section {
                DatePicker("Select a Date", selection: $date)
            } header: {
                Text("Add a date")
            }
            
            Section {
                //this will be an issue sooner or later
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
                
            } header: {
                Text("Add an amount")
            }
            
            
            Section {
                Picker("Category", selection: $category) {
                    ForEach(Category.categories, id: \.self) { category in
                        Text(category.name)
                    }
                    
                }
            } header: {
                Text("Add a category")
            }
            
            
            Button("Finish") {

                addItem(merchant: merchant, date: date, amount: amount, category: category)
                
            }
            Spacer()
            Button("Cancel") {
                showingAddTransaction = false

               
                
            }
        }.navigationBarTitle("Add a new transaction")
        
    }
    func addItem(merchant: String, date: Date, amount: Double, category: Category) {
        do {
            try realm.write({
                newTransaction.merchant = merchant
                newTransaction.amount = amount
                newTransaction.date = date
                newTransaction.category = category.name
                newTransaction.owner_id = realm.syncSession?.parentUser()?.id ?? ""
                $transactions.append(newTransaction)
                
            })
            showingAddTransaction = false
            
        } catch {
            //maybe a pop up?
            print("Failed to log in user: \(error.localizedDescription)")
            errorHandler.error = error
        }
           
       }
}
