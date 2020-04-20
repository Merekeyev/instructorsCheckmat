//
//  AttendanceService.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/17/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Moya

enum AttendanceService {
    
    case getGroups
    case getGroupTypes
    case createAttendance(body: [String: Any], token: String)
    case getAttendance(groupID: Int, date: String)
}

extension AttendanceService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return URL(string: ApiConstants.test)!
    }
    
    var path: String {
        switch self {
        case .getGroups:
            return ApiConstants.getGroups
        case .getGroupTypes:
            return ApiConstants.getGroupType
        case .createAttendance:
            return ApiConstants.createAttendance
        case .getAttendance(let groupID, let date):
            return ApiConstants.getAttendance
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGroups, .getGroupTypes, .getAttendance:
            return .get
        case .createAttendance:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getGroups, .getGroupTypes:
            return .requestPlain
        case .createAttendance(let body, _):
            return .requestCompositeParameters(bodyParameters: body, bodyEncoding: URLEncoding.httpBody, urlParameters: [:])
        case.getAttendance(let groupID, let date):
            return .requestParameters(parameters: ["filter[group_id]=": groupID, "filter[date]=": date], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .getAttendance:
            return .basic
        default:
            return .none
        }
    }
}

