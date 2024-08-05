//
//  StartLinkTestView.swift
//  Babka
//
//  Created by Bekki Antonelli on 7/1/24.
//


import UIKit
import LinkKit

class PlaidLinkViewController: UIViewController {

    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    let communicator = ServerCommunicator()
    var linkToken: String?
    var handler: Handler?
    
    
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
    

    @objc func startLinkWasPressed2(_ sender: UIButton) {
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
        self.communicator.callMyServer(path: "/server/tokens/swap_public_token", httpMethod: .post, params: ["public_token": publicToken]) {(result: Result<SwapPublicTokenResponse, ServerCommunicator.Error>) in
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
      
        self.communicator.callMyServer(path: "/server/tokens/create_link_token", httpMethod: .post) { (result: Result<LinkTokenCreateResponse, ServerCommunicator.Error>) in
            switch result {
            case .success(let response):
                self.linkToken = response.linkToken
                self.button.isEnabled = true
            case .failure(let error):
                print(error)
            }
        
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.backgroundColor = .cyan
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(startLinkWasPressed2), for: .touchUpInside)
        button.isEnabled = false

        self.view.addSubview(button)
        
        fetchLinkToken()
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }


}


