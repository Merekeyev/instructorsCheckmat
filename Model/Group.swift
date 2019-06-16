//
//  Group.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/16/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    var id: Int
    var typeId: Int
    var timeStart: String
    var timeEnd: String
    var day: String
    var status: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case typeId = "type_id"
        case timeStart = "time_start"
        case timeEnd = "time_end"
        case day = "day"
        case status = "status"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(typeId, forKey: .typeId)
        try container.encode(timeStart, forKey: .timeStart)
        try container.encode(timeEnd, forKey: .timeEnd)
        try container.encode(day, forKey: .day)
        try container.encode(status, forKey: .status)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        typeId = try container.decode(Int.self, forKey: .typeId)
        timeStart = try container.decode(String.self, forKey: .timeStart)
        id = try container.decode(Int.self, forKey: .id)
        timeEnd = try container.decode(String.self, forKey: .timeEnd)
        day = try container.decode(String.self, forKey: .day)
        status = try container.decode(Int.self, forKey: .status)
    }
}
