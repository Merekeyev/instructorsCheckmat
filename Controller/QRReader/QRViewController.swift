//
//  QRViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/19/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    @IBOutlet private weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    
    private var attendance: Attendance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
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
        guard let code = str else { return }
        presentAlert(withTitle: "Code", message: code)
    }
    
    func qrScanningDidStop() {
//        presentAlert(withTitle: "", message: "Произошла ошибка при сканировании")
    }
}
