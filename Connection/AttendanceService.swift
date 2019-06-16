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
    case createAttendance(body: [String: Any], user: User)
}

extension AttendanceService: TargetType {
    
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
        }
    }
    
    var method: Method {
        switch self {
        case .getGroups, .getGroupTypes:
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
            return .requestCompositeParameters(bodyParameters: body, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getGroupTypes, .getGroups:
            return nil
        case .createAttendance( _, let user):
            return ["Authorization": user.access_token]
        }
    }
}
