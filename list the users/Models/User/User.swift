//
//  User.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id:             Int
    let locationId:     Int
    let deviceCount:    Int
    let email:          String 
    let groupIds:       Array<Int>
    let groups:         Array<String>
    let firstName:      String
    let lastName:       String
    let username:       String
    let notes:          String
    let modified:       String
}

extension User {
    static func makeDefault() -> User {
        User(id: 0, locationId: 0, deviceCount: 0, email: "", groupIds: [], groups: [""], firstName: "", lastName: "", username: "", notes: "", modified: "")
    }
}

