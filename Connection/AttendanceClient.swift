//
//  AttendanceClient.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/17/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Moya
import KeychainAccess

class AttendanceClient {
    
    typealias FailureComletion = ( (String) -> Void )
    typealias GroupsSuccessCompletion = ( ([Group]) -> Void )
    typealias GroupTypesSuccessCompletion = ( ([GroupType]) -> Void )
    typealias AttendanceSuccessCompletion = ( (Attendance) -> Void )
    typealias AttendancesSuccessCompletion = (([Attendance]) -> Void)
    
    private var authPlugin: AccessTokenPlugin {
//        let credentionalData = Data(TokenManager.shared.token.utf8).base64EncodedString()
        return AccessTokenPlugin { TokenManager.shared.token }
    }
    
    private var provider: MoyaProvider<AttendanceService> {
        return MoyaProvider<AttendanceService>(plugins: [authPlugin])
    }
    
    private let provider1 = MoyaProvider<AttendanceService>(plugins: [CredentialsPlugin { target -> URLCredential? in
        return URLCredential(user: TokenManager.shared.token, password: "", persistence: .none)
    }])
    
    func getGroups(success: @escaping GroupsSuccessCompletion, failure: @escaping FailureComletion) {
        provider.request(.getGroups) { (response) in
            switch response.result {
            case .success(let result):
                if result.statusCode < 300 && result.statusCode >= 200 {
                    let groups = try? result.map([Group].self, using: JSONDecoder(), failsOnEmptyData: true)
                    guard let unwGroups = groups else {
                        failure("Unsafety unwrap")
                        return
                    }
                    success(unwGroups)
                } else {
                    failure("Произошла ошибка. Попробуйте позже")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getGroupTypes(success: @escaping GroupTypesSuccessCompletion, failure: @escaping FailureComletion) {
        provider.request(.getGroupTypes) { (response) in
            switch response.result {
            case .success(let result):
                if result.statusCode < 300 && result.statusCode >= 200 {
                    let groupTypes = try? result.map([GroupType].self, using: JSONDecoder(), failsOnEmptyData: true)
                    guard let types = groupTypes else {
                        failure("Unsafety unwrap")
                        return
                    }
                    success(types)
                } else {
                    failure("Произошла ошибка. Попробуйте позже")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func createAttendance(with params: [String: Any], token: String, success: @escaping AttendanceSuccessCompletion, failure: @escaping FailureComletion) {
        
        provider.request(.createAttendance(body: params, token: token)) { (response) in
            switch response.result {
            case .success(let result):
                if result.statusCode < 300 && result.statusCode >= 200 {
        
                } else {
                    failure("Произошла ошибка. Попробуйте позже")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getAttendaces(groupID: Int, date: String, success: @escaping AttendancesSuccessCompletion, failure: @escaping FailureComletion) {
        
        provider1.request(.getAttendance(groupID: groupID, date: date)) { (response) in
            switch response.result {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let attendances = try decoder.decode([Attendance].self, from: result.data)
                    success(attendances)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
