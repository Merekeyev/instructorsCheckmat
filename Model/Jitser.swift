//
//  Jitser.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 4/20/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import Foundation

struct Jitser {
    
    let firstName: String
    let lastName: String
    let userID: Int
    let clientID: Int
    let username: String
    let status: Int
    let days: Int
    let gender: String
    let points: Double?
    let abonementID: Int
    let birthDate: String?
    let discount: Int
    
    init(client: Client, gymUser: GymUser) {
        self.firstName = gymUser.firstName
        self.lastName = gymUser.lastName
        self.userID = gymUser.id
        self.clientID = client.id
        self.username = gymUser.userName
        self.status = gymUser.status
        self.days = client.days
        self.gender = client.gender
        self.points = client.points
        self.abonementID = client.abonementID
        self.birthDate = client.birthDate
        self.discount = client.discount
    }
}
