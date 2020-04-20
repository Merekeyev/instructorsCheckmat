//
//  SignInViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/10/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit
import SVProgressHUD
import KeychainAccess

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: CommonButton!
    
    private var signInClient: SignInClient
    private var username = ""
    private var password = ""
    private var keychain = Keychain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    init(with apiClient: SignInClient) {
        signInClient = apiClient
        super.init(nibName: "SignInViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        signIn()
    }
    
    @objc private func usernameTextFieldDidChange() {
        guard let text = usernameTextField.text else { return }
        username = text
    }
    
    @objc private func passwordTextFieldDidChange() {
        guard let text = passwordTextField.text else { return }
        password = text
    }
    
    private func signIn() {
        SVProgressHUD.show()
        signInClient.signIn(with: username, password: password, success: { (user) in
            SVProgressHUD.dismiss()
            try? self.keychain.set(user.access_token, key: "accessToken")
            try? self.keychain.set(String(describing: user.user_id), key: "userId")
            try? self.keychain.set(String(describing: user.id), key: "id")
            try? self.keychain.set(String(describing: user.expired_at), key: "expiredDate")
            TokenManager.shared.setup(token: user.access_token)
            
            let vc = AttendanceDateViewController(with: user)
            self.navigationController?.pushViewController(vc, animated: true)
        }) { (errorMessage) in
            SVProgressHUD.dismiss()
            print("DEBUG = \(errorMessage)")
            self.presentAlert(withTitle: "Ошибка", message: "Введен неправильный логин и/или пароль")
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            signIn()
        }
        
        return true
    }
}
