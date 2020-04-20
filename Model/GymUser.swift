//
//  GymUser.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/20/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import Foundation

struct GymUser: Decodable {
    
    let id: Int
    let userName: String
    let firstName: String
    let lastName: String
    let status: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case status = "status"
    }
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        userName = try container.decode(String.self, forKey: .userName)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        status = try container.decode(Int.self, forKey: .status)
    }
}
