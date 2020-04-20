//
//  Client.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/20/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import Foundation

struct Client: Decodable {
    
    let abonementID: Int
    let birthDate: String?
    let days: Int
    let discount: Int
    let gender: String
    let id: Int
    let points: Double?
    let rankID: Int?
    let userID: Int
    
    private enum CodingKeys: String, CodingKey {
        case abonementID = "abonement_id"
        case birthDate = "birth_date"
        case days = "days"
        case discount = "discount"
        case gender = "gender"
        case id = "id"
        case points = "points"
        case rankID = "rank_id"
        case userID = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        abonementID = try container.decode(Int.self, forKey: .abonementID)
        birthDate = try container.decode(String.self, forKey: .birthDate)
        days = try container.decode(Int.self, forKey: .days)
        discount = try container.decode(Int.self, forKey: .discount)
        gender = try container.decode(String.self, forKey: .gender)
        id = try container.decode(Int.self, forKey: .id)
        points = try container.decode(Double.self, forKey: .points)
        rankID = try container.decode(Int.self, forKey: .rankID)
        userID = try container.decode(Int.self, forKey: .userID)
    }
}
