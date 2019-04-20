//
//  LoginMoya.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/11/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation
import Moya

public enum SignInService {
    case signIn(username: String, password: String)
    case logOut
}

extension SignInService: TargetType {
    
    public var baseURL: URL {
        return URL(string: ApiConstants.test)!
    }
    
    public var path: String {
        switch self {
        case .signIn:
            return ApiConstants.signIn
        case .logOut:
            return ApiConstants.logout
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        case .logOut:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .signIn(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: URLEncoding.default)
        case .logOut:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
