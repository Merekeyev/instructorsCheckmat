//
//  AttendanceClient.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/17/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Moya

class AttendanceClient {
    
    typealias FailureComletion = ( (String) -> Void )
    typealias GroupsSuccessCompletion = ( ([Group]) -> Void )
    typealias GroupTypesSuccessCompletion = ( ([GroupType]) -> Void )
    
    private var provider = MoyaProvider<AttendanceService>()
    
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
                print(error.localizedDescription)
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
                print(error.localizedDescription)
            }
        }
    }
    
//    func createAttendance(success: @escaping )
}
