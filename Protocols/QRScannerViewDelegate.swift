//
//  QRScannerViewDelegate.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/19/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

protocol QRScannerViewDelegate: class {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
}
