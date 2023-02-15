//
//  UserEditorContent.swift
//  list the users
//
//  Created by Steven Hertz on 2/9/23.
//

import SwiftUI

struct UserEditorContent: View {
    @State var  user_start: User = User.makeDefault()
    
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
            .onDisappear {
                if isNew == false && isDeleted == false {
                    print("🚘 In on disAppear -UserEditorContent zero \(user.firstName) ")
                    if user_start == user {
                        print("its the same")
                    } else {
                        print("its different")
                        
                        Task {
                            do {
                                let response = try await ApiManager.shared.getDataNoDecode(from: .updateaUser(id: user.id, username: user.username, password: "123456" , email: user.email, firstName: user.firstName, lastName: user.lastName, locationId: user.locationId))
                                 
                            } catch let error as ApiError {
                                    //  FIXME: -  put in alert that will display approriate error message
                                print(error.description)
                            }
                        }
                        dismiss()
                    }
                }
             }

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
                                userCopy.locationId = 0
                                Task {
                                    do {
                                        let resposnseaddAUser: AddAUserResponse = try await ApiManager.shared.getData(from: .addUser(username: userCopy.username, password: "123456" , email: userCopy.email, firstName: userCopy.firstName, lastName: userCopy.lastName, locationId: userCopy.locationId))
                                        userCopy.id = resposnseaddAUser.id
                                        self.self.usersViewModel.users.append(self.userCopy)
                                        dump(resposnseaddAUser)
                                        print("fkffkkf")
                                    } catch let error as ApiError {
                                            //  FIXME: -  put in alert that will display approriate error message
                                        print(error)
                                    }
                                }
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
                    user_start = user
                    print("🚘 In on Appear - UserEditorContent ")
                }
                .onChange(of: userCopy){ _ in
                    if !isDeleted {
                        user = userCopy
                    }
                }
                .onDisappear {
//                    print("🚘 In on disAppear -UserEditorContent first \(user.firstName) ")
                }
            

        }
        .onDisappear {
//            print("🚘 In on disAppear -UserEditorContent second \(user.firstName)")
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
