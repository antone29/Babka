//
//  LoginResponse.swift
//  Babka
//
//  Created by Bekki Antonelli on 8/19/24.
//

import Foundation

struct LoginResponse: Decodable {
    let data: LoginResponseData
}

struct LoginResponseData: Decodable {
    let accessToken: String
    let refreshToken: String
}
