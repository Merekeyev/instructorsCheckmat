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
    
    func signIn(with username: String, password: String, success: @escaping SuccessCompletion, failure: @escaping FailureComletion) {
        provider.request(.signIn(username: username, password: password)) { (response) in
            switch response.result {
            case .success(let response):
                if response.statusCode < 300 && response.statusCode >= 200  {
                    let user = try? response.map(User.self, using: JSONDecoder(), failsOnEmptyData: true)
                    guard let unwUser = user else { return }
                    success(unwUser)
                } else if response.statusCode == 400 {
                    failure("Такого юзера не существует")
                } else if response.statusCode == 401 || response.statusCode == 422 {
                    failure("Неправильный логин и/или пароль")
                } else {
                    failure("Произошла ошибка, повторите позже")
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
