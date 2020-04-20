//
//  ApiConstants.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/11/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

class ApiConstants {
    static let test = "http://app.checkmat.kz/api/v2"
    
    static let signIn = "/auth/login"
    static let logout = "/auth/logout"
    
    static let getGroups = "/groups"
    static let getGroupType = "/group-types"
    
    static let createAttendance = "/attendances"
    static let getUsers = "/users"
    static let getClients = "/clients"
    static let getAttendance = "/attendances"
}

class TokenManager {
    
    var token: String {
        return accessToken
    }
    
    private var accessToken = String()
    
    static let shared = TokenManager()
    
    func setup(token: String) {
        accessToken = token
    }
}
