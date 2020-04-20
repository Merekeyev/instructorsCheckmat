//
//  AttendanceTableViewCell.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/20/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(jitser: Jitser) {
        titleLabel.text = jitser.firstName + " " + jitser.lastName + " Дней до окончания \(jitser.days)"
    }
}
