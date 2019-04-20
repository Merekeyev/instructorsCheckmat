//
//  LoginService.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/11/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation
import Moya

class SignInClient {
    
    typealias FailureComletion = ((String) -> Void)
    typealias SuccessCompletion = ((User) -> Void)
    
    private var provider = MoyaProvider<SignInService>()
    
    init() {
        
    }
    
    func signIn(with username: String, password: String, success: @escaping SuccessCompletion, failure: @escaping FailureComletion) {
        provider.request(.signIn(username: username, password: password)) { (response) in
            switch response.result {
            case .success(let response):
                let user = try! response.map(User.self, using: JSONDecoder(), failsOnEmptyData: true)
                success(user)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
