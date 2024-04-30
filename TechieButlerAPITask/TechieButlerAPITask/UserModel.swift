//
//  User.swift
//  TechieButlerAPITask
//
//  Created by Srinivas on 30/04/24.
//

import Foundation

struct Users: Codable {
    let users: [UserModel]
}

struct UserModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
