//
//  CommonButton.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/12/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import UIKit

class CommonButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = ColorConstants.themeColor
                self.setTitleColor(ColorConstants.whiteTextColor, for: .normal)
                self.isUserInteractionEnabled = true
            } else {
                self.backgroundColor = ColorConstants.grayColor
                self.setTitleColor(ColorConstants.grayTextColor, for: .normal)
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitleColor(ColorConstants.whiteTextColor, for: .normal)
        self.backgroundColor = ColorConstants.themeColor
        self.layer.cornerRadius = CGFloat(NumberConstants.cornerRadius)
    }
}
