//
//  ContentView.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI


import SwiftUI
import CoreData
import SwiftUICharts
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    var body: some View {
        if let user = app.currentUser {
            // Setup configuraton so user initially subscribes to their own tasks
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                
               if let foundSubscription = subs.first(named: Constants.myTransactions) {
                  foundSubscription.updateQuery(toType: Transaction.self, where: {
                     $0.owner_id == user.id
                  })
               } else {
                  // No subscription - create it
                  subs.append(QuerySubscription<Transaction>(name: Constants.myTransactions) {
                     $0.owner_id == user.id
                  })
               }
            }, rerunOnOpen: true)
            OpenRealmView(user: user)
                // Store configuration in the environment to be opened in next view
                .environment(\.realmConfiguration, config)
        } else {
            // If there is no user logged in, show the login view.
            LoginView()
        }
        
    }
    
}
