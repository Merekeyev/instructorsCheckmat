//
//  Attendance.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/17/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

final class Attendance: Decodable {
    
    var groupId: Int?
    var date: String?
    var clientId: Int?
    var authorId: Int?
    var id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case date = "date"
        case clientId = "client_id"
        case authorId = "author_id"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        groupId = try container.decode(Int.self, forKey: .groupId)
        date = try container.decode(String.self, forKey: .date)
        clientId = try container.decode(Int.self, forKey: .clientId)
        authorId = try container.decode(Int.self, forKey: .authorId)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    init() {}
}
