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
        VStack(spacing:15) {
            Text("Hello, \(user.username)!")
            Text("First Name: \(user.firstName)")
            Text("Last Name: \(user.lastName)")
            Text("Location: \(user.locationId)")
            Text("ID: \(user.id)")
            Text("Notes: \(user.notes)")
            Text("Modified: \(user.modified)")
            Text("device count: \(user.deviceCount)")
            Text("email: \(user.email)")
        }
       
    }
}

struct UserDetailContent_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailContent(user: User(id: 1, locationId: 1, deviceCount: 0, email: "", groupIds: [1], groups: ["qq"], firstName: "Sam", lastName: "Harris", username: "dlknnlknk", notes: "some notes", modified: "12/32/21"))
    }
}
