//
//  GroupResponse.swift
//  Test Making a urlSession
//
//  Created by Steven Hertz on 11/14/19.
//  Copyright © 2019 DIA. All rights reserved.
//

import Foundation

struct SchoolClassResponse: Codable {
    let code: Int
    let classes: [SchoolClass]
        
}

struct SchoolClass: Codable {
    let uuid:         String
    let name:         String
    let description:  String
    let userGroupId:  Int
}

