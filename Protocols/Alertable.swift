//
//  Alertable.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 7/8/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

protocol Alertable {
    
    func presentAlert(withTitle title: String, message : String, okAction: @escaping () -> Void)
}

extension Alertable where Self: UIViewController {
    
    func presentAlert(withTitle title: String, message : String, okAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            okAction()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
