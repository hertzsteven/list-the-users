//
//  UserDetailResponse.swift
//  Test Making a urlSession
//
//  Created by Steven Hertz on 12/10/19.
//  Copyright © 2019 DIA. All rights reserved.
//

import Foundation
struct UserDetailResponse: Codable {
    let code: Int
    let user: JSUser    
}


struct JSUser: Codable {
    
    let id:             Int
    let firstName:      String
    let lastName:       String
    let username:       String
    var notes:          String
    let teacherGroups:  Array<Int>
    var title:          String  { firstName }
    var picName:        String  { username  }
    var identity:       String  {String(id) }

}

extension JSUser: Equatable {
  static func == (lhs: JSUser, rhs: JSUser) -> Bool {
    return lhs.id == rhs.id 
  }
}
