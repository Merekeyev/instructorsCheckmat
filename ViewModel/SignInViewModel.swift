//
//  SignInViewModel.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/10/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class SignInViewModel {
    
    typealias UserCompletion = ((User)-> Void)
    typealias ErrorMessageCompletion = ((String)-> Void)
    
    private var signInClient: SignInClient?
    var isEnabled = Observable<Bool>(false)
    var username  = Observable<String>("")
    var password  = Observable<String>("")
    
    init(with apiClient: SignInClient) {
        signInClient = apiClient
        combineLatest(username, password) { username, password in
            return username.count > 0 && password.count > 0
        }.bind(to: isEnabled)
    }
    
    func signIn(username: String, password: String, success: @escaping UserCompletion, failure: @escaping ErrorMessageCompletion) {
        guard let signInClient = signInClient else {return}
        signInClient.signIn(with: username, password: password, success: { (user) in
            success(user)
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
}
