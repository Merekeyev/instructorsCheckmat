//
//  User.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/11/19.
//  Copyright © 2019 Checkmat.kz. All rights reserved.
//

import Foundation

class User: Codable {
    var access_token: String
    var user_id: Int
    var id: Int
    var expired_at: Int
    
    enum CodingKeys: String, CodingKey {
        case access_token
        case user_id
        case id
        case expired_at
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(access_token, forKey: .access_token)
        try container.encode(user_id, forKey: .user_id)
        try container.encode(id, forKey: .id)
        try container.encode(expired_at, forKey: .expired_at)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try container.decode(String.self, forKey: .access_token)
        user_id = try container.decode(Int.self, forKey: .user_id)
        id = try container.decode(Int.self, forKey: .id)
        expired_at = try container.decode(Int.self, forKey: .expired_at)
    }
    
    init(with userId: Int, accessToken: String, id: Int, expiredDate: Int) {
        user_id = userId
        access_token = accessToken
        self.id = id
        expired_at = expiredDate
    }
}
