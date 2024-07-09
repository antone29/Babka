//
//  BabkaApp.swift
//  Babka
//
//  Created by Bekki Antonelli on 6/6/24.
//

import SwiftUI
import RealmSwift

let theAppConfig = loadAppConfig()

let atlasUrl = theAppConfig.atlasUrl

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil))

@main
struct BabkaApp: SwiftUI.App {
    @StateObject var errorHandler = ErrorHandler(app: app)
    //used for importing data from calls
//    @StateObject var transactionListVM = TransactionListViewModel()

    
    var body: some Scene {
        WindowGroup {

            ContentView(app: app)
                .environmentObject(errorHandler)
//                .environmentObject(transactionListVM)
                .alert(Text("Error"), isPresented: .constant(errorHandler.error != nil)) {
                    Button("OK", role: .cancel) { errorHandler.error = nil }
                } message: {
                    Text(errorHandler.error?.localizedDescription ?? "")
                }
  
                
        }
    }
}

final class ErrorHandler: ObservableObject {
    @Published var error: Swift.Error?

    init(app: RealmSwift.App) {
        // Sync Manager listens for sync errors.
        app.syncManager.errorHandler = { syncError, syncSession in
            self.error = syncError
        }
    }
}
