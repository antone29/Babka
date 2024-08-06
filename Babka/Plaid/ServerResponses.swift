//
//  ServerResponses.swift
//  Babka
//
//  Created by Bekki Antonelli on 7/1/24.
//


import Foundation

enum UserConnectionStatus: String, Codable {
    case connected
    case disconnected
}

struct UserStatusResponse: Codable {
    let userStatus: UserConnectionStatus
    let userId: String
}

 struct LinkTokenCreateResponse: Codable {
    let linkToken: String
    let expiration: String
}
 
struct SwapPublicTokenResponse: Codable {
    let success: Bool
}

struct SimpleAuthResponse: Codable{
    let accountName: String
    let accountMask: String
    let routingNumber: String
}
