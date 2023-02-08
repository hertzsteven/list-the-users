//
//  UserDetailContent.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct UserDetailContent: View {
    var user: User
    
    
    var body: some View {
        Text("Hello, \(user.username)!")
    }
}

//struct UserDetailContent_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailContent()
//    }
//}
