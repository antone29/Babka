//
//  TabOverView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import RealmSwift

struct TabOverView: View {
    var body: some View {
        NavigationView {
            TabView {
                
                SpendingView()
                    .tabItem {
                        Label("Spending", systemImage: "dollarsign.circle")
                    }
                CategoryView()
                    .tabItem {
                        Label("Budget", systemImage: "chart.pie")
                    }
                TransactionListView()
                    .tabItem {
                        Label("Transactions", systemImage: "list.bull.clipboard")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
            }

            .padding()
            
            .frame(maxWidth: .infinity)
            // }
            //.background(Color.background2)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

#Preview {
    TabOverView()
}
