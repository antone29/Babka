//
//  StartLinkTestView.swift
//  Babka
//
//  Created by Bekki Antonelli on 7/1/24.
//

import SwiftUI
import LinkKit

struct StartLinkTestView: View {
    
    @State var isStartLinkButtonEnabled = false
    
    var body: some View {
        Button("Start"){
            startLinkWasPressed()
        }.disabled(!isStartLinkButtonEnabled)
        .onAppear(perform: {
           
            fetchLinkToken()
        })
    }
    
    let communicator = ServerCommunicator()
    @State var linkToken: String?
//    var handler: Handler?
    
    
    private func createLinkConfiguration(linkToken: String) -> LinkTokenConfiguration {
        // Create our link configuration object
        // This return type will be a LinkTokenConfiguration object
        var linkTokenConfig = LinkTokenConfiguration(token: linkToken) { success in
            print("Link was finished successfully! \(success)")
            self.exchangePublicTokenForAccessToken(success.publicToken)
        }
        linkTokenConfig.onExit = { linkEvent in
            print("user exited link early \(linkEvent)")
        }
        linkTokenConfig.onEvent = { linkEvent in
            print("hit an event \(linkEvent.eventName)")
            
        }
        return linkTokenConfig
    }
    
    func startLinkWasPressed() {
        guard let linkToken = linkToken else {return}
        let config = createLinkConfiguration(linkToken: linkToken)
        
        let creationResult = Plaid.create(config)
        switch creationResult {
        case .success(let handler):
            self.handler = handler
            handler.open(presentUsing: .viewController(self))
        case .failure(let error):
            print("hanlder creation error \(error)")
        }
    }
    
    private func exchangePublicTokenForAccessToken(_ publicToken: String) {
        // Exchange our public token for an access token
        self.communicator.callMyServer(path: "server/swap_public_token", httpMethod: .post, params: ["public_token": publicToken]) {(result: Result<SwapPublicTokenResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(_):
                // TODO: actually look at the value of the respond
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("got an error \(error)")
            }
        }
    }
    
    
    private func fetchLinkToken() {
        self.communicator.callMyServer(path: "server/generate_link_token", httpMethod: .post) { (result: Result<LinkTokenCreateResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(let response):
                self.linkToken = response.linkToken
                self.isStartLinkButtonEnabled = true
            case .failure(let error):
                print(error)
            }
        
        }

    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


