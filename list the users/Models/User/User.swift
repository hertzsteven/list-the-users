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
    let email:          Int?
    let groupIds:       Array<Int>
    let groups:         Array<String>
    let firstName:      String
    let lastName:       String
    let username:       String
    let notes:          String
    let modified:       String?
}

