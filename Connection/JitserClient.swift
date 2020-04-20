//
//  JitserClient.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/23/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import Foundation
import Moya

class JitserClient {
    
    typealias ClientSuccessCompletion = (([Client]) -> Void)
    typealias GymUserSuccessCompletion = (([GymUser]) -> Void)
    typealias FailureComletion = ( (String) -> Void )
    
    private let provider = MoyaProvider<JitserService>(plugins: [CredentialsPlugin { target -> URLCredential? in
        return URLCredential(user: TokenManager.shared.token, password: "", persistence: .none)
    }])
    
    func getClient(id: Int, success: @escaping ClientSuccessCompletion, failure: @escaping FailureComletion) {
        
        provider.request(.getClient(id: id)) { (response) in
            switch response.result {
            case .success(let result):
                do {
                    try print(result.mapJSON())
                    let decoder = JSONDecoder()
                    let clients = try decoder.decode([Client].self, from: result.data)
                    success(clients)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getGymUser(id: Int, success: @escaping GymUserSuccessCompletion, failure: @escaping FailureComletion) {
        
        provider.request(.getUser(id: id)) { (response) in
            switch response.result {
            case .success(let result):
                do {
                    try print(result.mapJSON())
                    let decoder = JSONDecoder()
                    let gymUsers = try decoder.decode([GymUser].self, from: result.data)
                    success(gymUsers)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
