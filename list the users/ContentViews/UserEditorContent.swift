//
//  UserEditorContent.swift
//  list the users
//
//  Created by Steven Hertz on 2/9/23.
//

import SwiftUI

struct UserEditorContent: View {
    @Binding var user: User
    
    @State var isNew = false
    @State private var isDeleted = false
    
    var body: some View {
        HStack {
            Text("hello me")
            Text(user.username)
        }
       
    }
}

//struct UserEditorContent_Previews: PreviewProvider {
//    static var previews: some View {
//        UserEditorContent(user:  User(id: 1, locationId: 1, deviceCount: 0, email: "", groupIds: [1], groups: ["qq"], firstName: "Sam", lastName: "Harris", username: "dlknnlknk", notes: "some notes", modified: "12/32/21"))
//    }
//}
