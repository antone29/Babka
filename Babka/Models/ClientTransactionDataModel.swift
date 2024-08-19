//
//  ClientTransactionDataModel.swift
//  Babka
//
//  Created by Bekki Antonelli on 8/7/24.
//

import Foundation
//import SwiftUIFontIcon
//import RealmSwift

@MainActor
class ClientTransactionDataModel: ObservableObject {
    @Published var translist : [Transaction2] = []
    let communicator = ServerCommunicator()
  
    
    func transactionSync() async {
        self.communicator.callMyServer(path: "server/transactions/sync", httpMethod: .post) { (result: Result<[Transaction2], ServerCommunicator.Error>) in
            switch result {
            case .success(let response ):
                print("successfully got transactions to sync")
            case .failure(let error):
                print("Got an error \(error)")
            }
            
        }

    }
    
    func transactionsList() async {
        self.communicator.callMyServer(path: "server/transactions/list", httpMethod: .get) { (result: Result<[Transaction2], ServerCommunicator.Error>) in
            switch result {
            case .success(let response ):
                for each in response {
                    self.translist.append(each)
                }
            case .failure(let error):
                print("Got an error \(error)")
            }
            
        }
    }
    
 
    

}
