//
//  FullGroup.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/16/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

class FullGroup {
    
    private var groupType: GroupType
    private var group: Group
    
    var id: Int {
        return group.id
    }
    
    var title: String {
        return groupType.title
    }
    
    var timeStart: String {
        return group.timeStart
    }
    
    var timeEnd: String {
        return group.timeEnd
    }
    
    var fullText: String {
        return groupType.title + ", " + group.day + ", " + group.timeStart + " - " + group.timeEnd
    }
    
    var shortText: String {
        return groupType.title + ", " + group.day
    }
    
    var groupId: Int {
        return group.id
    }
    
    init(with group: Group, type: GroupType) {
        self.group = group
        self.groupType = type
    }
}
