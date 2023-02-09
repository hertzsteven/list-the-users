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
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var userCopy = User.makeDefault()
    
    private var isUserDeleted: Bool {
        !usersViewModel.exists(userCopy) && !isNew
    }
    
    var body: some View {
        VStack {
            UserDetailContent(user: $userCopy, isDeleted: $isDeleted, isNew: $isNew)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
                                usersViewModel.users.append(userCopy)
                                dismiss()
                            }
                        } label: {
                            Text(isNew ? "Add" : "")
                        }
                        .disabled(userCopy.username.isEmpty)
                    }
                })
                .onAppear {
                    userCopy = user
                }
                .onChange(of: userCopy){ _ in
                    if !isDeleted {
                        user = userCopy
                    }
                }
        }
        .overlay(alignment: .center) {
            if isUserDeleted {
                Color(UIColor.systemBackground)
                Text("User Deleted. Select an User.")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
}

//struct UserEditorContent_Previews: PreviewProvider {
//    static var previews: some View {
//        UserEditorContent(user:  User(id: 1, locationId: 1, deviceCount: 0, email: "", groupIds: [1], groups: ["qq"], firstName: "Sam", lastName: "Harris", username: "dlknnlknk", notes: "some notes", modified: "12/32/21"))
//    }
//}
