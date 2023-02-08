//
//  ContentView.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct UserListContent: View {
    
    @StateObject var usersViewModel = UsersViewModel()
    
    var names = ["Sam", "David", "Harry", "Frank", "Max"]
    	
    var body: some View {
        NavigationStack {
            
            
            List(usersViewModel.users) { theUser in
                CustomRow(user: theUser)
            }
            .navigationTitle("Users")
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
                    Image(systemName: "person.circle.fill")
                    Text(user.firstName)
                    Text(user.lastName)
                    Text("\(user.deviceCount) devices")
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
        UserListContent()
    }
}
