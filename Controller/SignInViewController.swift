//
//  SignInViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/10/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: CommonButton!
    
    private var viewModel: SignInViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
    
    private func bindViewModel() {
        viewModel.isEnabled.bind(to: signInButton.reactive.isEnabled)
    }

    init(with viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SignInViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        viewModel.signIn(username: usernameTextField.text!, password: passwordTextField.text!, success: { [weak self] (user) in
            guard let self = self else { return }
            let attendanceVC = AttendanceDateViewController(with: user)
            self.navigationController?.pushViewController(attendanceVC, animated: true)
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    @objc private func usernameTextFieldDidChange() {
        guard let text = usernameTextField.text else { return }
        viewModel.username.next(text)
    }
    
    @objc private func passwordTextFieldDidChange() {
        guard let text = passwordTextField.text else { return }
        viewModel.password.next(text)
    }
    
    
}
