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
    
    
    
//    @State private var isPickingSymbol = false
    
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

 
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("New User", text: $user.username)
                        .font(.title2)
                }
                .padding([.top, .bottom], 8)
                TextField("First Name", text: $user.firstName )
                    .padding([.top, .bottom], 8)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Last Name", text: $user.lastName )
 
                    .padding([.top, .bottom], 8)
//               TextField("Location", text: $user.locationId )
                TextField("Location", value: $user.locationId, formatter: formatter)
                    .padding([.top, .bottom], 8)
//                TextField("ID", text: $user.id )
//                    .padding([.top, .bottom], 8)
                TextField("Notes", text: $user.notes )
                    .padding([.top, .bottom], 8)
                TextField("Modified", text: $user.modified )
                    .padding([.top, .bottom], 8)
//                TextField("device count", text: $user.deviceCount )
//                    .padding([.top, .bottom], 8)
                TextField("email", text: $user.email )
                    .padding([.top, .bottom], 8)
                 Text("Something")
                    .fontWeight(.bold)
                
            }
 
            
            if !isNew {
                Button(role: .destructive, action: {
                    print("we are about to delete the user \(user.id)")
                    isDeleted = true
                    
                    Task {
                        do {
                            let response = try await ApiManager.shared.getDataNoDecode(from: .deleteaUser(id: user.id))
                            dump(response)
                            print("break")
                            usersViewModel.delete(user)
                        } catch let error as ApiError {
                                //  FIXME: -  put in alert that will display approriate error message
                            print(error.description)
                        }
                    }
                    dismiss()

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
//            TextField("Hello, \(user.username)!")
//            TextField("First Name: \(user.firstName)")
//            TextField("Last Name: \(user.lastName)")
//            TextField("Location: \(user.locationId)")
//            TextField("ID: \(user.id)")
//            TextField("Notes: \(user.notes)")
//            TextField("Modified: \(user.modified)")
//            TextField("device count: \(user.deviceCount)")
//            TextField("email: \(user.email)")
//        }Field
//
//    }
}

//struct UserDetailContent_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailContent(user: <#Binding<User>#>, isDeleted: <#Binding<Bool>#>, isNew: <#Binding<Bool>#>, usersViewModel: <#UsersViewModel#>)
//    }
//}
