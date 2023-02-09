//
//  UserDetailContent.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct UserDetailContent: View {
    
    @Binding var user: User
    @Binding var isDeleted: Bool
    @Binding var isNew: Bool
    
    @EnvironmentObject var usersViewModel: UsersViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPickingSymbol = false
    
//    @FocusState var focusedTask: EventTask?


    
//    var user: User
 
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("New User", text: $user.username)
                        .font(.title2)
                }
                .padding(.top, 5)
                Text("Something")
                    .fontWeight(.bold)
            }
            
            if !isNew {
                Button(role: .destructive, action: {
                    isDeleted = true
                    dismiss()
                    usersViewModel.delete(user)
                }, label: {
                    Text("Delete User")
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(UIColor.systemRed))
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }

        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
//    var body: some View {
//        VStack(spacing:15) {
//            Text("Hello, \(user.username)!")
//            Text("First Name: \(user.firstName)")
//            Text("Last Name: \(user.lastName)")
//            Text("Location: \(user.locationId)")
//            Text("ID: \(user.id)")
//            Text("Notes: \(user.notes)")
//            Text("Modified: \(user.modified)")
//            Text("device count: \(user.deviceCount)")
//            Text("email: \(user.email)")
//        }
//
//    }
}

//struct UserDetailContent_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailContent(user: <#Binding<User>#>, isDeleted: <#Binding<Bool>#>, isNew: <#Binding<Bool>#>, usersViewModel: <#UsersViewModel#>)
//    }
//}
