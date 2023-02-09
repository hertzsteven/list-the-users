//
//  ContentView.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct UserListContent: View {
    
    @StateObject var usersViewModel = UsersViewModel()
    
    @State var newUser: User
    @State private var isAddingNewUser = false
    
    	
    var body: some View {
        NavigationView {
            List {
                ForEach (usersViewModel.users) { theUser in
                    CustomRow(user: theUser)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Users")
            .toolbar {
                        ToolbarItem {
                            Button {
                                newUser = User.makeDefault()
                                 isAddingNewUser = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
            
                    .sheet(isPresented: $isAddingNewUser) {
                        Text("hello all")
//                        NavigationView {
//                            UserEditorContent(user: $newUser, isNew: true)
//                        }
                    }

        }
    }
}

struct CustomRow: View {
    var user: User
    
    var body: some View {
            NavigationLink {
                UserDetailContent(user: user)
            } label: {
                HStack {
                    Label("\(user.firstName) \(user.lastName)", systemImage: "person.circle")
                        .labelStyle(CustomLabelStyle())
//                    Image(systemName: "person.circle.fill").foregroundColor(.blue)
//                    Text(user.firstName)
//                    Text(user.lastName)
//                    Text("\(user.deviceCount) devices")
                    Spacer()
                }
                .foregroundColor(Color.primary)
                .font(.body)
                .padding([.top, .bottom],10)
            }
    }
}

struct UserListContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListContent(newUser: User.makeDefault())
    }
}
