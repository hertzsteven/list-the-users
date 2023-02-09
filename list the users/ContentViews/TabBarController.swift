//
//  TabBarController.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import SwiftUI

struct TabBarController : View {
    var body: some View {
        TabView {
//            NavigationView {
            UserListContent(newUser: User.makeDefault())
//            }
                .tabItem {
                    Label("students", systemImage: "person")
//                    Image(systemName: "person")
//                    Text("Students")
                }

            Text("Outgoing Phone Calls")
                .tabItem {
                    
                    Image(systemName: "phone.arrow.up.right")
                    Text("Outgoing")
                }
        }
    }
}

struct TabBarController_Previews: PreviewProvider {
    static var previews: some View {
        TabBarController()
    }
}
