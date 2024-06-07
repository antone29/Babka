//
//  Extensions.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import Foundation
import SwiftUI


extension Color {
    static let background2 = Color("Background")
    static let icon2 = Color("Icon")
    static let text2 = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension Date {
    
    func dateParsed() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"
        let stringDate = formatter.string(from : self)
        return stringDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    public func roundedTo2Digits() -> Double {
        return (self * 100).rounded()/100
     }
}
