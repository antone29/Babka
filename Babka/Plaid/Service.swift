////
////  Service.swift
////  Babka
////
////  Created by Bekki Antonelli on 8/6/24.
////
//
//import Foundation
//
//class Service {
//    let communicator = ServerCommunicator()
//    
//    func makeSimpleCallWasPressed() {
//        // Ask our server to make a call to the Plaid API on behalf of our user
//        self.communicator.callMyServer(path: "server/tokens/simple_auth", httpMethod: .get) { (result: Result<SimpleAuthResponse, ServerCommunicator.Error>) in
//            switch result {
//            case .success(let response ):
//                simpleCallResults = "i revtrevied routing number \(response.routingNumber) for \(response.accountName) (xxxxxxxxxxx\(response.accountMask))"
//            case .failure(let error):
//                print("Got an error \(error)")
//            }
//            
//        }
//    }
//    
//    func transactionSync() {
//        self.communicator.callMyServer(path: "server/transactions/sync", httpMethod: .post) { (result: Result<[Transaction2], ServerCommunicator.Error>) in
//            switch result {
//            case .success(let response ):
//                print("successfully got transactions to sync")
//            case .failure(let error):
//                print("Got an error \(error)")
//            }
//            
//        }
//
//    }
//    
//     
//    
//
//    private func determineUserStatus() {
//        self.communicator.callMyServer(path: "/server/get_user_info", httpMethod: .get) {
//            (result: Result<UserStatusResponse, ServerCommunicator.Error>) in
//            
//            switch result {
//            case .success(let serverResponse):
//                userLabel = "Hello user \(serverResponse.userId)!"
//                switch serverResponse.userStatus {
//                case .connected:
//                    self.statusLabel = "You are connected to your bank via Plaid. Make a call!"
////                    self.connectToPlaid.setTitle("Make a new connection", for: .normal)
//                    self.isCallButtonEnabled = true;
//                case .disconnected:
//                    self.statusLabel = "You should connect to a bank"
//                   // self.connectToPlaid.setTitle("Connect", for: .normal)
//                    self.isCallButtonEnabled = false;
//                }
//                self.isConnectToPlaidEnabled = true;
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
