//
//  JisterService.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/23/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import Foundation
import Moya

public enum UserParamsType: String {
    case username
    case firstName = "first_name"
    case lastName = "last_name"
}

public enum JitserService {
    case getUser(id: Int)
    case getClient(id: Int)
}

extension JitserService: TargetType, AccessTokenAuthorizable {

    public var baseURL: URL {
        return URL(string: ApiConstants.test)!
    }

    public var path: String {
        switch self {
        case .getUser:
            return ApiConstants.getUsers
        case .getClient:
            return ApiConstants.getClients
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .getClient:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getClient(let id):
            return .requestParameters(parameters: ["filter[id]=": id], encoding: URLEncoding.default)
        case .getUser(let id):
            return .requestParameters(parameters: ["filter[id]=": id], encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return nil
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
        case .getClient, .getUser:
            return .basic
        default:
            return .none
        }
    }
}
