//
//  GroupTypes.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 6/16/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

struct GroupType: Codable {
    
    var id: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
    }
}
