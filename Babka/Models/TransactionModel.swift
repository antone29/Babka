//
//  TransactionModel.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//


import Foundation
import SwiftUIFontIcon
import RealmSwift


class Transaction2:  Codable,  ObservableObject, Identifiable{
    
    let id, category: String
    let bankName: BankName
    let amount: Double
    let userID: String
    let currencyCode: CurrencyCode
    let accountName: AccountName
    let date: String
    let authorizedDate: String?
    let isRemoved: Int
    let accountID, name: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case bankName = "bank_name"
        case amount
        case userID = "user_id"
        case currencyCode = "currency_code"
        case accountName = "account_name"
        case date
        case authorizedDate = "authorized_date"
        case isRemoved = "is_removed"
        case accountID = "account_id"
        case name
    }
}

extension Transaction2 : Hashable {

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)

    }
    static func == (lhs: Transaction2, rhs: Transaction2) -> Bool {
        return lhs.id == rhs.id
    }

    
}

enum AccountName: String, Codable {
    case plaidChecking = "Plaid Checking"
    case plaidSaving = "Plaid Saving"
}

enum BankName: String, Codable {
    case tdBank = "TD Bank"
}

enum CurrencyCode: String, Codable {
    case usd = "USD"
}

typealias Trans = [Transaction2]

class Transaction: Object, ObjectKeyIdentifiable, Identifiable, Decodable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var institution: String
    @Persisted var account: String
    @Persisted var merchant: String
    @Persisted var amount: Double
    @Persisted var type: TransactionType.RawValue
    @Persisted var categoryId: Int
    @Persisted var category: String
    @Persisted var isPending: Bool
    @Persisted var isTransfer: Bool
    @Persisted var isExpense: Bool
    @Persisted var isEdited: Bool
    @Persisted var owner_id: String
    
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: {$0.id == categoryId}) {
            return category.icon
        }
        
        return .question
    }
    
//    var dateParsed: Date {
//        date.dateParsed()
//    }
//    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
//    var month: String {
//        dateParsed.formatted(.dateTime.year().month(.wide))
//    }
}

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
    
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    
    var mainCategoryId: Int?
}

extension Category {
    
    static let autoAndTransport = Category(id: 1, name:"Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name:"Bills & Utilities", icon:.file_invoice_dollar)
    static let entertainment = Category(id: 3, name:"Entertainment", icon:.film)
    static let feesAndCharges = Category(id: 4, name:"Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name:"Home", icon:.home)
    static let income = Category(id: 7, name:"Income", icon:.dollar_sign)
    static let shopping = Category(id: 8, name:"Shopping", icon:.shopping_cart)
    static let transfer = Category(id: 9, name:"Transfer", icon:.exchange_alt)
    
}

extension Category : Hashable, Identifiable {
    
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    
    static let all: [Category] = categories 
}
