//
//  AttendanceViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/24/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController {
    
    @IBOutlet weak var viewControllerStackViews: UIStackView!
    @IBOutlet weak var handView: UIView!
    @IBOutlet weak var qrView: UIView!
    
    private var qrVC: QRViewController {
        let qrVC = QRViewController(nibName: "QRViewController", bundle: nil)
        return qrVC
    }
    
    private var handVC: HandViewController {
        let handVC = HandViewController(nibName: "HandViewController", bundle: nil)
        return handVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addChild(qrVC)
        
        qrVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        qrVC.view.frame = qrView.bounds
        
        qrView.addSubview(qrVC.view)
        qrVC.didMove(toParent: self)
        
        
        addChild(handVC)
        
        handVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        handVC.view.frame = handView.bounds
        
        handView.addSubview(handVC.view)
        handVC.didMove(toParent: self)
    }

}
