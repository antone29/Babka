//
//  PlaidTestView.swift
//  Babka
//
//  Created by Bekki Antonelli on 7/1/24.
//

import SwiftUI

struct PlaidTestView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PlaidLinkViewController
    
    func makeUIViewController(context: Context) -> PlaidLinkViewController {
        let vc = PlaidLinkViewController()
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: PlaidLinkViewController, context: Context) {
        //
    }
    
    
    
}

struct BaseView: View {
    
    let communicator = ServerCommunicator()
    @State private var simpleCallResults = ""
    @State var userLabel = "Hello User!"
    @State var statusLabel = ""
    @State var isCallButtonEnabled = false
    @State var isConnectToPlaidEnabled = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(userLabel)
                NavigationLink("Connect to Bank") {
                    PlaidTestView()
                }
                
                Button("Make a simple call") {
                    makeSimpleCallWasPressed()
                }.disabled(!isCallButtonEnabled)
                Text(simpleCallResults)
            }
        }.onAppear(perform: {
           determineUserStatus()
        })
    }
    
    func makeSimpleCallWasPressed() {
        // Ask our server to make a call to the Plaid API on behalf of our user
        self.communicator.callMyServer(path: "server/simple_auth", httpMethod: .get) { (result: Result<SimpleAuthResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(let response ):
                simpleCallResults = "i revtrevied routing number \(response.routingNumber) for \(response.accountName) (xxxxxxxxxxx\(response.accountMask))"
            case .failure(let error):
                print("Got an error \(error)")
            }
            
        }
    }

    private func determineUserStatus() {
        self.communicator.callMyServer(path: "/server/get_user_info", httpMethod: .get) {
            (result: Result<UserStatusResponse, ServerCommunicator.Error>) in
            
            switch result {
            case .success(let serverResponse):
                userLabel = "Hello user \(serverResponse.userId)!"
                switch serverResponse.userStatus {
                case .connected:
                    self.statusLabel = "You are connected to your bank via Plaid. Make a call!"
//                    self.connectToPlaid.setTitle("Make a new connection", for: .normal)
                    self.isCallButtonEnabled = true;
                case .disconnected:
                    self.statusLabel = "You should connect to a bank"
                   // self.connectToPlaid.setTitle("Connect", for: .normal)
                    self.isCallButtonEnabled = false;
                }
                self.isConnectToPlaidEnabled = true;
            case .failure(let error):
                print(error)
            }
        }
    }
}



