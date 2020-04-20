//
//  QRViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/19/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit
import KeychainAccess
import SVProgressHUD

class QRViewController: UIViewController, Alertable {
    
    @IBOutlet private weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    
    private var attendance: Attendance
    private var attendanceClient = AttendanceClient()
    private var keychain = Keychain()
    private var clientId = ""
    private var clientDays = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            SVProgressHUD.show()
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            SVProgressHUD.dismiss()
            scannerView.stopScanning()
        }
    }

    init(with attendance: Attendance) {
        self.attendance = attendance
        super.init(nibName: QRViewController.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QRViewController: QRScannerViewDelegate {
    func qrScanningDidFail() {
        presentAlert(withTitle: "Ошибка", message: "Произошла ошибка при сканировании")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        guard let code = str, let groupId = attendance.groupId, let date = attendance.date, let author = try? keychain.getString("userId"), let authorId = author, let tok = try? keychain.getString("accessToken"), let token = tok  else { return }
        guard let authorIdInt = Int(authorId), let clientIdInt = Int(code) else { return }
        clientId = code
        let params: [String: Any] = ["group_id": String(describing: groupId), "date": date, "client_id": clientIdInt, "author_id": authorIdInt]
        attendanceClient.createAttendance(with: params, token: token, success: { (attendance) in
            SVProgressHUD.dismiss()
            
        }) { (error) in
            SVProgressHUD.dismiss()
            self.presentAlert(withTitle: "Ошибка", message: error)
        }
    }
    
    func qrScanningDidStop() {
        presentAlert(withTitle: "Успешно", message: "У вас осталось \(clientDays)") {
            self.scannerView.startScanning()
        }
    }
}
